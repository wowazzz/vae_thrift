#include <iostream>
#include <fstream>
#include <boost/filesystem/operations.hpp>
#include <boost/smart_ptr.hpp>

using namespace boost;
using namespace std;

#include "../gen-cpp/VaeDb.h"
#include "context.h"
#include "site.h"
#include "logger.h"
#include "response.h"
#include "query.h"
#include "s3.h"

Site::Site(string su, bool stagingMode_, string const & rawxml) : stagingMode(stagingMode_) {
  subdomain = su;
  secretKey = read_s3(subdomain+"-secret");
  if (stagingMode) subdomain += ".staging"; 
  loadXmlDoc(rawxml);
  L(info) << "[" << subdomain << "] opened";
}
  
Site::~Site() {
  L(info) << "[" << subdomain << "] closed";
  for (NodeList::iterator it = nodesToClean.begin(); it != nodesToClean.end(); it++) {
    (*it)->last = (*it)->children = NULL;
    (*it)->properties = NULL;
    (*it)->_private = NULL;
  }
  for (NodeList::iterator it = nodesToClean2.begin(); it != nodesToClean2.end(); it++) {
    if ((*it)->children) (*it)->children->next = NULL;
    (*it)->last = (*it)->children;
    (*it)->properties = NULL;
    (*it)->_private = NULL;
  }
  for (StructureMap::iterator it = structures.begin(); it != structures.end(); it++) {
    delete it->second;
  }
  nodesToClean.clear();
  nodesToClean2.clear();
  freeContexts(rootNode);
  xmlFreeDoc(doc);
  nodes.clear();
  structures.clear();
}

void Site::freeContexts(xmlNodePtr node) {
  for (xmlNode *child = node->children; child; child = child->next) {
    if (child->type == XML_ELEMENT_NODE) {    
      if (child->_private != NULL) {
        delete (Context *)child->_private;
      }
      freeContexts(child);
    }
  }
}

string Site::getSubdomain() {
  return subdomain;
}

void Site::loadXmlDoc(string const & rawxml) {
  if ((doc = xmlReadMemory(rawxml.c_str(), rawxml.size(), subdomain.c_str(), NULL, 0)) == NULL) {
    L(warning) << "[" << subdomain << "] could not open/parse XML";
    throw VaeDbInternalError("Could not open/parse XML file!");
  }
  xmlXPathOrderDocElems(doc);
  rootNode = rootDesignNode = NULL;
  Query _rootNodeQuery(this);
  _rootNodeQuery.runRawQuery(NULL, "/website/content", "website root node");
  if (_rootNodeQuery.getSize() != 1) {
    throw VaeDbInternalError("Could not find root content node in XML file");
  }
  rootNode = _rootNodeQuery.getNode(0);
  Query _rootDesignNodeQuery(this);
  _rootDesignNodeQuery.runRawQuery(NULL, "/website/design", "website design node");
  if (_rootDesignNodeQuery.getSize() != 1) {
    throw VaeDbInternalError("Could not find root design node in XML file");
  }
  rootDesignNode = _rootDesignNodeQuery.getNode(0);
  xmlNode *next;
  for (xmlNode *child = rootNode->children; child; child = next) {
    next = child->next;
    if (child->type == XML_ELEMENT_NODE) {
      Context *ctxt = new Context(this, child);
      if (ctxt->killMe) {
        xmlUnlinkNode(child);
        xmlFreeNode(child);
        delete ctxt;
      } else {
        child->_private = (void *)ctxt;
      }
    }
  }
  for (ContextList::iterator it = associationsToInitialize.begin(); it != associationsToInitialize.end(); it++) {
    (*it)->initializeAssociation();
  }
  associationsToInitialize.clear();
}

VaeDbStructure *Site::structureFromStructureId(int structureId) {
  StructureMap::const_iterator it;
  if ((it = structures.find(structureId)) != structures.end()) {
    return it->second;
  }
  stringstream q;
  q << "/website/design//*[@id=" << structureId << "]";
  Query _query(this);
  _query.runRawQuery(NULL, q.str(), q.str());
  if (!_query.getNode(0)) return NULL;
  VaeDbStructure *structure = new VaeDbStructure();
  structure->id = structureId;
  for (xmlAttr *child = _query.getNode(0)->properties; child; child = child->next) {
    if (!strcmp((const char *)child->name, "name")) structure->name = (const char *)child->children->content;
    if (!strcmp((const char *)child->name, "permalink")) structure->permalink = (const char *)child->children->content;
    if (!strcmp((const char *)child->name, "type")) structure->type = (const char *)child->children->content;
  }
  structures[structureId] = structure;
  return structure;
}
  
void Site::validateSecretKey(string testSecretKey) {
  if (secretKey != testSecretKey) {
    L(warning) << "[" << subdomain << "] secret key mismatch: " << secretKey << " <> " << testSecretKey;
    throw VaeDbInternalError("Secret key mismatch");
  }
}
