#include <iostream>
#include <fstream>
#include <boost/filesystem/operations.hpp>
#include <boost/smart_ptr.hpp>
#include <boost/thread/locks.hpp>

using namespace boost;
using namespace std;

#include "vae_db_handler.h"
#include "site.h"
#include "context.h"
#include "logger.h"
#include "reaper.h"
#include "response.h"
#include "session.h"
#include "s3.h"

void eatErrors(void * ctx, const char * msg, ...) { }

boost::shared_ptr<Site> VaeDbHandler::getSite(string subdomain, string secretKey, bool stagingMode) {
  string xml("");
  string sitesKey(stagingMode ? subdomain + ".staging" : subdomain);
  boost::unique_lock<boost::mutex> lockSite(_get_site_mutex(subdomain, stagingMode));

  boost::shared_ptr<Site> site(_getSite(sitesKey, secretKey));

  if (site) return site;

  if (!testMode) {
    xml = read_s3(subdomain+"-feed.xml");
  }
  site = _loadSite(subdomain, stagingMode, xml);
  site->validateSecretKey(secretKey);
  return site;
}

inline
boost::mutex & VaeDbHandler::_get_site_mutex(std::string const & subdomain, bool stagingMode) {
  string sitesKey(stagingMode ? subdomain + ".staging" : subdomain);
  boost::unique_lock<boost::mutex> lockSites(sitesMutex);
  if (siteMutexes.count(sitesKey)) {
    return *siteMutexes[sitesKey];
  } else {
    return *(siteMutexes[sitesKey] = new boost::mutex);
  }
}

inline boost::shared_ptr<class Site>
VaeDbHandler::_loadSite(string const & subdomain, bool stagingMode, string const & xml) {
  boost::shared_ptr<Site> site;
  site.reset(new Site(subdomain, stagingMode, xml));
  boost::unique_lock<boost::mutex> lockSites(sitesMutex);
  string sitesKey(stagingMode ? subdomain + ".staging" : subdomain);
  return sites[sitesKey] = site;
}

boost::shared_ptr<Site> VaeDbHandler::_getSite(string const & sitesKey, string const & secretKey) {
  boost::unique_lock<boost::mutex> lock(sitesMutex);

  if (sites.count(sitesKey)) {
    sites[sitesKey]->validateSecretKey(secretKey);
    return sites[sitesKey];
  }

  return boost::shared_ptr<Site>();
}

VaeDbHandler::VaeDbHandler(QueryLog &queryLog, MemcacheProxy &memcacheProxy, MysqlProxy &mysqlProxy)
  :  queryLog(queryLog), memcacheProxy(memcacheProxy), mysqlProxy(mysqlProxy) {

  nextSessionId = 1;
  xmlInitParser();
  xmlSetGenericErrorFunc(NULL, eatErrors);
  writePid();
  new Reaper(this, mysqlProxy);
  L(error) << "VaeDB Running";
}

VaeDbHandler::~VaeDbHandler() {
  L(info) << "shutdown";
  xmlCleanupParser();
}

void VaeDbHandler::closeSession(const int32_t sessionId, const string& secretKey) {
  QueryLogEntry entry(queryLog);
  entry.method_call("closeSession") << sessionId << secretKey << "\n";

  boost::unique_lock<boost::mutex> lock(sessionsMutex);
  if (sessions.count(sessionId)) {
    sessions.erase(sessionId);
  } else {
    L(warning) << "closeSession() called with an invalid session ID: " << sessionId;
  }
}

void VaeDbHandler::createInfo(VaeDbCreateInfoResponse& _return, const int32_t sessionId, const int32_t responseId, const string& query) {
  QueryLogEntry entry(queryLog);
  entry.method_call("createInfo") << sessionId << responseId << query << "\n";

  boost::shared_ptr<class Session> session;
  {
    boost::unique_lock<boost::mutex> lock(sessionsMutex);
    if (sessions.count(sessionId)) {
      session = sessions[sessionId];
    } else {
      L(warning) << "createInfo() called with an invalid session ID: " << sessionId;
      return;
    }
  }
  entry.set_subdomain(session->getSite()->getSubdomain());
  session->createInfo(_return, responseId, query);
}

void VaeDbHandler::data(VaeDbDataResponse& _return, const int32_t sessionId, const int32_t responseId) {
  QueryLogEntry entry(queryLog);
  entry.method_call("data") << sessionId << responseId << "\n";

  boost::shared_ptr<class Session> session;
  {
    boost::unique_lock<boost::mutex> lock(sessionsMutex);
    if (sessions.count(sessionId)) {
      session = sessions[sessionId];
    } else {
      L(warning) << "data() called with an invalid session ID: " << sessionId;
      return;
    }
  }
  entry.set_subdomain(session->getSite()->getSubdomain());
  session->data(_return, responseId);
}

void VaeDbHandler::get(VaeDbResponse& _return, const int32_t sessionId, const int32_t responseId, const string& query, const map<string, string> & options) {
  QueryLogEntry entry(queryLog);
  entry.method_call("get") << sessionId << responseId << query << options << "\n";

  boost::shared_ptr<class Session> session;
  {
    boost::unique_lock<boost::mutex> lock(sessionsMutex);
    if (sessions.count(sessionId)) {
      session = sessions[sessionId];
    } else {
      L(warning) << "get() called with an invalid session ID: " << sessionId;
      return;
    }
  }
  entry.set_subdomain(session->getSite()->getSubdomain());
  session->get(_return, responseId, query, options);
}

SessionMap& VaeDbHandler::getSessions() {
  return sessions;
}

void VaeDbHandler::openSession(VaeDbOpenSessionResponse& _return, const string& subdomain, const string& secretKey, const bool stagingMode, const int32_t suggestedSessionId) {
  QueryLogEntry entry(queryLog);
  entry.method_call("openSession") << subdomain << secretKey << stagingMode << suggestedSessionId << "\n";

  int32_t sessionId;
  sessionId = suggestedSessionId;
  boost::shared_ptr<Site> site = getSite(subdomain, secretKey, stagingMode);
  {
    boost::unique_lock<boost::mutex> lock(sessionsMutex);
    while (sessions.count(sessionId)) {
      sessionId = rand();
    }
    boost::shared_ptr<Session> session(new Session(site));
    sessions[sessionId] = session;
    entry.set_subdomain(session->getSite()->getSubdomain());
    _return.generation = session->getSite()->getGeneration();
  }

  _return.session_id = sessionId;
}

int8_t VaeDbHandler::ping() {
  QueryLogEntry entry(queryLog);
  entry.method_call("ping") << "\n";

  L(info) << "[ping]";
  return 0;
}

void VaeDbHandler::resetSite(string const & subdomain, string const & secretKey) {
  QueryLogEntry entry(queryLog);
  entry.method_call("resetSite") << subdomain << secretKey << "\n";
  L(info) << "reset: " << subdomain;

  _resetSite(subdomain, secretKey, false);
}

void VaeDbHandler::reloadSite(string const & subdomain) {
  bool reload_prod;
  bool reload_staging;

  {
    boost::unique_lock<boost::mutex> lock(sitesMutex);
    reload_prod = sites.count(subdomain) > 0;
    reload_staging = sites.count(subdomain + ".staging") > 0;
  }

  string rawxml(read_s3(subdomain+"-feed.xml"));
  _resetSite(subdomain, "", true);


  if (reload_prod) {
     boost::unique_lock<boost::mutex> lockSite(_get_site_mutex(subdomain, 0));
    _loadSite(subdomain, 0, rawxml);
  }

  if (reload_staging) {
     boost::unique_lock<boost::mutex> lockSite(_get_site_mutex(subdomain, 1));
    _loadSite(subdomain, 1, rawxml);
  }
}

inline
void VaeDbHandler::_resetSite(string const & subdomain, string const & secretKey, bool force) {
  boost::unique_lock<boost::mutex> lock(sitesMutex);
  if (sites.count(subdomain)) {
    _eraseSite(subdomain, secretKey, force);
  }

  string staging(subdomain + ".staging");

  if (sites.count(staging)) {
    _eraseSite(staging, secretKey, force);
  }
}

inline
void VaeDbHandler::_eraseSite(string const & sitesKey, string const & secretKey, bool force) {
  //expects siteMutex held

  if(!force)
    sites[sitesKey]->validateSecretKey(secretKey);

  sites.erase(sitesKey);
}

void VaeDbHandler::structure(VaeDbStructureResponse& _return, const int32_t sessionId, const int32_t responseId) {
  QueryLogEntry entry(queryLog);
  entry.method_call("structure") << sessionId << responseId << "\n";

  boost::shared_ptr<class Session> session;
  {
    boost::unique_lock<boost::mutex> lock(sessionsMutex);
    if (sessions.count(sessionId)) {
      session = sessions[sessionId];
    } else {
      L(warning) << "structure() called with an invalid session ID: " << sessionId;
      return;
    }
  }
  entry.set_subdomain(session->getSite()->getSubdomain());
  session->structure(_return, responseId);
}

void VaeDbHandler::writePid() {
  ofstream pidfile;
  pidfile.open("/tmp/vaedb.pid");
  if (pidfile.is_open()) {
    pidfile << getpid();
  } else {
    L(warning) << "Could not write PID file /tmp/vaedb.pid";
  }
  pidfile.close();
}

void VaeDbHandler::shortTermCacheGet(string &_return, const int32_t sessionId, string const & key, const int32_t flags) {
  boost::shared_ptr<class Session> session;
  {
    boost::unique_lock<boost::mutex> lock(sessionsMutex);
    if (sessions.count(sessionId)) {
      session = sessions[sessionId];
    } else {
      L(warning) << "shortTermCacheGet() called with an invalid session ID: " << sessionId;
      return;
    }
  }
  string fullKey = "VaedbProxy:" + session->getSite()->getSubdomain() + ":" + key;
  string answer(memcacheProxy.get(fullKey, flags));
  _return = answer;
}

void VaeDbHandler::shortTermCacheSet(const int32_t sessionId, string const & key, string const & value, const int32_t flags, const int32_t expireInterval) {
  boost::shared_ptr<class Session> session;
  {
    boost::unique_lock<boost::mutex> lock(sessionsMutex);
    if (sessions.count(sessionId)) {
      session = sessions[sessionId];
    } else {
      L(warning) << "shortTermCacheSet() called with an invalid session ID: " << sessionId;
      return;
    }
  }
  string fullKey = "VaedbProxy:" + session->getSite()->getSubdomain() + ":" + key;
  memcacheProxy.set(fullKey, value, flags, expireInterval);
}

void VaeDbHandler::shortTermCacheDelete(const int32_t sessionId, string const & key) {
  boost::shared_ptr<class Session> session;
  {
    boost::unique_lock<boost::mutex> lock(sessionsMutex);
    if (sessions.count(sessionId)) {
      session = sessions[sessionId];
    } else {
      L(warning) << "shortTermCacheDelete() called with an invalid session ID: " << sessionId;
      return;
    }
  }
  string fullKey = "VaedbProxy:" + session->getSite()->getSubdomain() + ":" + key;
  memcacheProxy.remove(fullKey);
}

void VaeDbHandler::sessionCacheGet(string &_return, const int32_t sessionId, string const & key) {
  boost::shared_ptr<class Session> session;
  {
    boost::unique_lock<boost::mutex> lock(sessionsMutex);
    if (sessions.count(sessionId)) {
      session = sessions[sessionId];
    } else {
      L(warning) << "sessionCacheGet() called with an invalid session ID: " << sessionId;
      return;
    }
  }
  _return = mysqlProxy.sessionCacheGet(session->getSite()->getSubdomain(), key);
}

void VaeDbHandler::sessionCacheSet(const int32_t sessionId, string const & key, string const & value) {
  boost::shared_ptr<class Session> session;
  {
    boost::unique_lock<boost::mutex> lock(sessionsMutex);
    if (sessions.count(sessionId)) {
      session = sessions[sessionId];
    } else {
      L(warning) << "sessionCacheSet() called with an invalid session ID: " << sessionId;
      return;
    }
  }
  mysqlProxy.sessionCacheSet(session->getSite()->getSubdomain(), key, value);
}

void VaeDbHandler::sessionCacheDelete(const int32_t sessionId, string const & key) {
  boost::shared_ptr<class Session> session;
  {
    boost::unique_lock<boost::mutex> lock(sessionsMutex);
    if (sessions.count(sessionId)) {
      session = sessions[sessionId];
    } else {
      L(warning) << "sessionCacheDelete() called with an invalid session ID: " << sessionId;
      return;
    }
  }
  mysqlProxy.sessionCacheDelete(session->getSite()->getSubdomain(), key);
}

void VaeDbHandler::longTermCacheGet(string &_return, const int32_t sessionId, string const & key, const int32_t renewExpiry, const int32_t useShortTermCache) {
  boost::shared_ptr<class Session> session;
  {
    boost::unique_lock<boost::mutex> lock(sessionsMutex);
    if (sessions.count(sessionId)) {
      session = sessions[sessionId];
    } else {
      L(warning) << "longTermCacheGet() called with an invalid session ID: " << sessionId;
      return;
    }
  }
  string fullKey = "VaedbProxy:" + session->getSite()->getSubdomain() + "LongTerm2:" + key;
  if (useShortTermCache) {
    string answer(memcacheProxy.get(fullKey, 0));
    if (answer.length() > 0) {
      _return = answer;
      return;
    }
  }
  _return = mysqlProxy.longTermCacheGet(session->getSite()->getSubdomain(), key, renewExpiry);
  memcacheProxy.set(fullKey, _return, 0, 86400);
}

void VaeDbHandler::longTermCacheSet(const int32_t sessionId, string const & key, string const & value, const int32_t expireInterval, const int32_t isFilename) {
  boost::shared_ptr<class Session> session;
  {
    boost::unique_lock<boost::mutex> lock(sessionsMutex);
    if (sessions.count(sessionId)) {
      session = sessions[sessionId];
    } else {
      L(warning) << "longTermCacheSet() called with an invalid session ID: " << sessionId;
      return;
    }
  }
  string fullKey = "VaedbProxy:" + session->getSite()->getSubdomain() + "LongTerm2:" + key;
  mysqlProxy.longTermCacheSet(session->getSite()->getSubdomain(), key, value, expireInterval, isFilename);
  memcacheProxy.set(fullKey, value, 0, 86400);
}

void VaeDbHandler::longTermCacheDelete(const int32_t sessionId, string const & key) {
  boost::shared_ptr<class Session> session;
  {
    boost::unique_lock<boost::mutex> lock(sessionsMutex);
    if (sessions.count(sessionId)) {
      session = sessions[sessionId];
    } else {
      L(warning) << "longTermCacheDelete() called with an invalid session ID: " << sessionId;
      return;
    }
  }
  string fullKey = "VaedbProxy:" + session->getSite()->getSubdomain() + "LongTerm2:" + key;
  mysqlProxy.longTermCacheDelete(session->getSite()->getSubdomain(), key);
  memcacheProxy.remove(fullKey);
}

void VaeDbHandler::longTermCacheEmpty(const int32_t sessionId) {
  boost::shared_ptr<class Session> session;
  {
    boost::unique_lock<boost::mutex> lock(sessionsMutex);
    if (sessions.count(sessionId)) {
      session = sessions[sessionId];
    } else {
      L(warning) << "longTermCacheEmpty() called with an invalid session ID: " << sessionId;
      return;
    }
  }
  mysqlProxy.longTermCacheEmpty(session->getSite()->getSubdomain());
}

void VaeDbHandler::longTermCacheSweeperInfo(VaeDbDataForContext& _return, const int32_t sessionId) {
  boost::shared_ptr<class Session> session;
  {
    boost::unique_lock<boost::mutex> lock(sessionsMutex);
    if (sessions.count(sessionId)) {
      session = sessions[sessionId];
    } else {
      L(warning) << "longTermCacheSweeperInfo() called with an invalid session ID: " << sessionId;
      return;
    }
  }
  mysqlProxy.longTermCacheSweeperInfo(_return, session->getSite()->getSubdomain());
}

int32_t VaeDbHandler::sitewideLock(const int32_t sessionId) {
  boost::shared_ptr<class Session> session;
  {
    boost::unique_lock<boost::mutex> lock(sessionsMutex);
    if (sessions.count(sessionId)) {
      session = sessions[sessionId];
    } else {
      L(warning) << "sitewideLock() called with an invalid session ID: " << sessionId;
      return -1;
    }
  }
  return mysqlProxy.lock(session->getSite()->getSubdomain());
}

int32_t VaeDbHandler::sitewideUnlock(const int32_t sessionId) {
  boost::shared_ptr<class Session> session;
  {
    boost::unique_lock<boost::mutex> lock(sessionsMutex);
    if (sessions.count(sessionId)) {
      session = sessions[sessionId];
    } else {
      L(warning) << "sitewideUnlock() called with an invalid session ID: " << sessionId;
      return -1;
    }
  }
  return mysqlProxy.unlock(session->getSite()->getSubdomain());
}
