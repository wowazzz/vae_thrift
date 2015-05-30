#!/usr/local/bin/thrift --gen php --gen rb --gen cpp

exception VaeDbInternalError {
  1:string message
}

exception VaeDbQueryError {
  1:string message
}

exception VaeSyntaxError {
  1:string message
}

struct VaeDbContext {
  1:i32 id
  2:i32 structure_id
  3:string type
  4:string permalink
  5:string data
  6:map<string,string> dataMap
}

struct VaeDbCreateInfo {
  1:i32 structure_id
  2:i32 row_id
}

struct VaeDbStructure {
  1:i32 id
  2:string name
  3:string type
  4:string permalink
}

struct VaeDbResponseForContext {
  1:list<VaeDbContext> contexts
  2:i32 totalItems
}

struct VaeDbResponse {
  1:i32 id
  2:list<VaeDbResponseForContext> contexts
}

struct VaeDbCreateInfoResponse {
  1:list<VaeDbCreateInfo> contexts
}

struct VaeDbDataForContext {
  1:map<string,string> data
}

struct VaeDbDataResponse {
  1:list<VaeDbDataForContext> contexts
}

struct VaeDbStructureResponse {
  1:list<VaeDbStructure> contexts
}

service VaeRubyd {
  
  byte ping()
  
  byte fixDocRoot(1:string path)
  
  string haml(1:string text)
    throws (1:VaeSyntaxError se)
  
  string sass(1:string text, 2:string load_path)
    throws (1:VaeSyntaxError se)
  
  string scss(1:string text, 2:string load_path)
    throws (1:VaeSyntaxError se)

}

service VaeDb {

  byte ping()
    
  void closeSession(1:i32 session_id, 2:string secret_key)
    throws (1:VaeDbInternalError e)
    
  VaeDbCreateInfoResponse createInfo(1:i32 session_id, 2:i32 response_id, 3:string query)
    throws (1:VaeDbInternalError ie, 2:VaeDbQueryError qe)
    
  VaeDbDataResponse data(1:i32 session_id, 2:i32 response_id)
    throws (1:VaeDbInternalError ie)
    
  VaeDbResponse get(1:i32 session_id, 2:i32 response_id, 3:string query, 4:map<string,string> options)
    throws (1:VaeDbInternalError ie, 2:VaeDbQueryError qe)
    
  i32 openSession(1:string site, 2:string secret_key, 3:bool staging_mode, 4:i32 suggested_session_id)
    throws (1:VaeDbInternalError e)
  
  void resetSite(1:string site, 2:string secret_key)
    throws (1:VaeDbInternalError e)
    
  VaeDbStructureResponse structure(1:i32 session_id, 2:i32 response_id)
    throws (1:VaeDbInternalError ie)

  string shortTermCacheGet(1:string key, 2:i32 flags)

  void shortTermCacheSet(1:string key, 2:string value, 3:i32 flags, 4:i32 expireInterval)

  string longTermCacheGet(1:string key, 2:i32 renewExpiry)

  void longTermCacheSet(1:string key, 2:string value, 3:i32 expireInterval, 4:i32 isFilename)

  void longTermCacheEmpty()

}
