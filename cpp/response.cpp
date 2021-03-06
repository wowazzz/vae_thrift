#include <iostream>
#include <math.h>
#include <boost/algorithm/string.hpp>
#include <boost/bind.hpp>
#include <boost/smart_ptr.hpp>
#include <pcrecpp.h>

using namespace std;
using namespace boost;

#include "../gen-cpp/VaeDb.h"
#include "site.h"
#include "context.h"
#include "response.h"
#include "logger.h"
#include "query.h"
#include "util.h"

#define ZERO_PADDING_AMOUNT 12

Response::Response(boost::shared_ptr<Site> s, boost::shared_ptr<Response> parent, const string &q, const map<string, string> &options) : site(s) {
  filter = unique = false;
  groups = skip = 0;
  page = 1;
  paginate = 99999999;
  sortType = None;
  
  map<string,string>::const_iterator it;
  if ((it = options.find("skip")) != options.end()) {
    skip = atoi(it->second.c_str());
    L(debug) << "   skipping " << skip;
  }
  if ((it = options.find("groups")) != options.end()) {
    groups = atoi(it->second.c_str());
    L(debug) << "   grouping by " << groups;
  }
  if ((it = options.find("limit")) != options.end()) {
    paginate = atoi(it->second.c_str());
    L(debug) << "   limiting to " << paginate;
  }
  if ((it = options.find("paginate")) != options.end()) {
    paginate = atoi(it->second.c_str());
    L(debug) << "   paginating by " << paginate;
  }
  if ((it = options.find("unique")) != options.end()) {
    unique = true;
    boost::split(uniqueFields, it->second, boost::is_any_of(","));
    L(debug) << "   uniqueing on " << it->second;
  }
  if ((it = options.find("page")) != options.end()) {
    if (it->second == "last()" || it->second == "last") {
      page = -1;
      L(debug) << "   page is last";
    } else if (it->second == "all" || it->second == "all()") {
      paginate = 999999999;
    } else {
      page = atoi(it->second.c_str());
      L(debug) << "   page is " << page;
    }
  }
  if ((it = options.find("filter")) != options.end()) {
    filter = true;
    string buf;
    stringstream ss(it->second);
    while (ss >> buf) {
      char *cbuf;
      cbuf = (char *)malloc(buf.length()+1);
      if (cbuf == NULL) {
        L(error) << "malloc fail";
        abort();
      }
      strcpy(cbuf, buf.c_str());
      filterTerms.push_back(cbuf);
    }
  }
  if ((it = options.find("order")) != options.end()) {
    string order = it->second;
    if (order != "") {
      pcrecpp::RE("REVERSE\\(", pcrecpp::RE_Options().set_caseless(true)).Replace("DESC(", &order);
      if (!strcasecmp(order.c_str(), "DESC()")) {
        sortType = Reverse;
      } else if (!strcasecmp(order.c_str(), "RAND()")) {
        sortType = Shuffle;
      } else {
        sortType = Specific;
        vector<string> terms;
        boost::split(terms, order, boost::is_any_of(","));
        for (vector<string>::const_iterator it = terms.begin(); it != terms.end(); it++) {
          SortField field;
          if (pcrecpp::RE("DESC\\(([.A-Za-z0-9_()\\/]+)\\)", pcrecpp::RE_Options().set_caseless(true)).FullMatch(*it, &field.field)) {
            field.direction = Desc;
          } else {
            field.field = *it;
            field.direction = Asc;
          }
          if (pcrecpp::RE("COUNT\\(([.A-Za-z0-9_()\\/]+)\\)", pcrecpp::RE_Options().set_caseless(true)).FullMatch(field.field, &field.field)) {
            field.count = true;
          } else {
            field.count = false;
          }
          sortFields.push_back(field);
        }
      }
    }
  }
    
  if (parent) {
    for (ResponseContextList::const_iterator it = parent->contexts.begin(); it != parent->contexts.end(); it++) {
      for (ContextList::const_iterator it2 = (*it).contexts.begin(); it2 != (*it).contexts.end(); it2++) {
        query((*it2), q, options);
      }
    }
  } else {
    query(NULL, q, options);
  }
}

Response::Response(boost::shared_ptr<Site> s, boost::shared_ptr<Response> parent, const string &query) : site(s) {
  filter = false;
  if (parent) {
    for (ResponseContextList::const_iterator it = parent->contexts.begin(); it != parent->contexts.end(); it++) {
      for (ContextList::const_iterator it2 = (*it).contexts.begin(); it2 != (*it).contexts.end(); it2++) {
        createInfo((*it2), query);
      }
    }
  } else {
    createInfo(NULL, query);
  }
}

Response::~Response() {
  if (filter) {
    vector<char *>::size_type size = filterTerms.size();
    for (vector<char *>::size_type i = 0; i != size; i++) {
      free(filterTerms[i]);
    }
  }
}

void Response::createInfo(Context *context, const string &query) {
  VaeDbCreateInfo ci;
  string mainQuery, lastPart;
  vector<string> queryParts;
  boost::split(queryParts, query, boost::is_any_of("/"));
  lastPart = queryParts.back();
  queryParts.pop_back();
  mainQuery = boost::join(queryParts, "/");
  if (mainQuery == "" && lastPart != "" && (queryParts.size() > 0)) {
    // query was something like /artists
    context = NULL;
  } else if (mainQuery != "") {
    LRUKey key = {context, mainQuery};
    boost::shared_ptr<Query> p_query = site->fetch_query(key);
    if (p_query->getSize() > 0) {
      context = (Context *)p_query->getNode(0)->_private;
    }
  }
  if (context) {
    ci.row_id = context->getId();
  } else {
    ci.row_id = 0;
  }
  if (atoi(lastPart.c_str()) != 0) {
    string error = "invalid path for creating: '" + query + "'";
    VaeDbQueryError e;
    e.message = error.c_str();
    throw e;
  }
  Query structureQuery(site.get());
  structureQuery.runDesignQuery(context, lastPart);
  if (structureQuery.getSize() > 0) {
    for (xmlAttr *child = structureQuery.getNode(0)->properties; child; child = child->next) {
      if (!strcmp((const char *)child->name, "id")) ci.structure_id = atoi((const char *)child->children->content);
    }
  } else {
    string error = "could not find path for creating: '" + query + "'";
    VaeDbQueryError e;
    e.message = error.c_str();
    throw e;
  }
  createInfos.push_back(ci);
}

bool Response::filterMatch(xmlNode *node) {
  filterRemainingTerms = filterTerms;
  filterMatchRecursive(node, 0);
  return (filterRemainingTerms.size() == 0);
}

void Response::filterMatchRecursive(xmlNode *node, int reentry) {
  for (xmlNode *child = node->children; child; child = child->next) {
    if (child->type == XML_ELEMENT_NODE) {
      if (reentry < 1) filterMatchRecursive(child, reentry + 1);
    } else if (child->type == XML_TEXT_NODE) {
      for (vector<char *>::iterator it = filterRemainingTerms.begin(); it!=filterRemainingTerms.end(); ) {
        if (strcasestr((const char *)child->content, *it)) {
          it = filterRemainingTerms.erase(it);
        } else {
          it++;
        }
      }
    }
  }
}

void Response::query(Context *context, const string &q, const map<string, string> &options) {
  int size, start, end, skip_, paginate_, page_;
  LRUKey key = {context, q};
  boost::shared_ptr<Query> p_query = site->fetch_query(key);
  ResponseContext _return;
  _return.total = size = p_query->getSize();
  skip_ = skip;
  paginate_ = paginate;
  page_ = page;
  L(debug) << "  found " << size << " result" << (size != 1 ? "s" : "");
  if (groups) {
    if (page_ <= 0) {
      page_ = 1;
    }
    for (int j = 0; j < page_; j++) {
      if (j > 0) skip_ += paginate_;
      paginate_ = (int)ceil((float)(size - skip_) / (groups-j));
    }
  } else {
    if (page_ == -1) {
      page_ = (int)ceil((float)(size - skip_) / paginate_);
    }
    if (page_ <= 0) {
      page_ = 1;
    }
    skip_ += (int)ceil((page_ - 1) * paginate_);
  }
  if (paginate_ < 1) {
    paginate_ = 1;
  }
  if (skip_ < 0) {
    skip_ = 0;
  }
  end = size;
  if (sortType == None) {
    start = skip_;
    if ((paginate_ + start) < end) {
      end = (paginate_ + skip_);
    }
  } else {
    start = 0;
  }
  if (end > size) {
    end = size;
  }
  if (filter || unique) { 
    int skipped = 0;
    int included = 0;
    _return.total = 0;
    uniqueFound.clear();
    for (int i = 0; i < size; i++) {
  	  xmlNode *node = p_query->getNode(i);
      if ((!filter || filterMatch(node)) && (!unique || uniqueMatch(node))) {
        _return.total++;
        if (skipped < start) {
          skipped++;
        } else if ((included + skipped) < end) {
          Context *ctxt = (Context *)node->_private;
          if (ctxt) {
            _return.contexts.push_back(ctxt);
            included++;
          }
        }
      }
    }
  } else {
    for (int i = start; i < end; i++) {
  	  xmlNode *node = p_query->getNode(i);
      Context *ctxt = (Context *)node->_private;
      if (ctxt) _return.contexts.push_back(ctxt);
    }
  }
  if (sortType == Reverse) {
    reverse(_return.contexts.begin(), _return.contexts.end());
  } else if (sortType == Shuffle) {
    random_shuffle(_return.contexts.begin(), _return.contexts.end());
  } else if (sortType == Specific) {
    sort(_return.contexts.begin(), _return.contexts.end(), boost::bind(&Response::sortCallback, this, _1, _2));
  }
  if (sortType != None) {
    ContextList::iterator end_of_erase;
    if (_return.contexts.size() > skip_)
      end_of_erase = _return.contexts.begin() + skip_;
    else
      end_of_erase = _return.contexts.end();

    _return.contexts.erase(_return.contexts.begin(), end_of_erase);
    if (_return.contexts.size() > paginate_) {
      _return.contexts.resize(paginate_);
    }
  }
  contexts.push_back(_return);
}

bool Response::sortCallback(Context *lhs, Context *rhs) {
  bool comp = false;
  for (vector<SortField>::const_iterator it = sortFields.begin(); it != sortFields.end(); it++) {
    if ((*it).field == "id") {
      comp = (lhs->getId() < rhs->getId());
    } else if ((*it).count) {
      int lcount = lhs->getCount((*it).field);
      int rcount = rhs->getCount((*it).field);
      if (lcount == rcount) continue;
      comp = (lcount < rcount);
    } else {
      string ldata = lhs->getData((*it).field);
      string rdata = rhs->getData((*it).field);
      int icomp = str_compare_nat(ldata, rdata);
      if (icomp == 0) continue;
      comp = icomp > 0;
    }
    if ((*it).direction == Desc) {
      comp = !comp;
    }
    break;
  }
  return comp;
}

bool Response::uniqueMatch(xmlNode *node) {
  Context *context = (Context *)node->_private;
  string val;
  for (vector<string>::iterator it = uniqueFields.begin(); it != uniqueFields.end(); it++) {
    val += context->getData(*it) + "~!~";
  }
  if (uniqueFound.find(val) == uniqueFound.end()) {
    uniqueFound.insert(val);
    return true;
  }
  return false;
}

void Response::writeVaeDbCreateInfoResponse(VaeDbCreateInfoResponse &_return) {
  for (CreateInfoList::iterator it = createInfos.begin(); it != createInfos.end(); it++) {
    _return.contexts.push_back(*it);
  }
}

void Response::writeVaeDbDataResponse(VaeDbDataResponse &_return) {
  for (ResponseContextList::const_iterator it = contexts.begin(); it != contexts.end(); it++) {
    for (ContextList::const_iterator it2 = (*it).contexts.begin(); it2 != (*it).contexts.end(); it2++) {
      if (*it2) _return.contexts.push_back((*it2)->toVaeDbDataForContext());
    }
  }
}

void Response::writeVaeDbResponse(VaeDbResponse &_return) {
  for (ResponseContextList::const_iterator it = contexts.begin(); it != contexts.end(); it++) {
    VaeDbResponseForContext context_list;
    for (ContextList::const_iterator it2 = (*it).contexts.begin(); it2 != (*it).contexts.end(); it2++) {
      if (*it2) context_list.contexts.push_back((*it2)->toVaeDbContext());
    }
    context_list.totalItems = (*it).total;
    _return.contexts.push_back(context_list);
  }
}

void Response::writeVaeDbStructureResponse(VaeDbStructureResponse &_return) {
  for (ResponseContextList::const_iterator it = contexts.begin(); it != contexts.end(); it++) {
    for (ContextList::const_iterator it2 = (*it).contexts.begin(); it2 != (*it).contexts.end(); it2++) {
      if (*it2) _return.contexts.push_back((*it2)->toVaeDbStructureForContext());
    }
  }
}
