// This autogenerated skeleton file illustrates how to build a server.
// You should copy it to another filename to avoid overwriting it.

#include "VaeDb.h"
#include <thrift/protocol/TBinaryProtocol.h>
#include <thrift/server/TSimpleServer.h>
#include <thrift/transport/TServerSocket.h>
#include <thrift/transport/TBufferTransports.h>

using namespace ::apache::thrift;
using namespace ::apache::thrift::protocol;
using namespace ::apache::thrift::transport;
using namespace ::apache::thrift::server;

using boost::shared_ptr;

class VaeDbHandler : virtual public VaeDbIf {
 public:
  VaeDbHandler() {
    // Your initialization goes here
  }

  int8_t ping() {
    // Your implementation goes here
    printf("ping\n");
  }

  void closeSession(const int32_t session_id, const std::string& secret_key) {
    // Your implementation goes here
    printf("closeSession\n");
  }

  void createInfo(VaeDbCreateInfoResponse& _return, const int32_t session_id, const int32_t response_id, const std::string& query) {
    // Your implementation goes here
    printf("createInfo\n");
  }

  void data(VaeDbDataResponse& _return, const int32_t session_id, const int32_t response_id) {
    // Your implementation goes here
    printf("data\n");
  }

  void get(VaeDbResponse& _return, const int32_t session_id, const int32_t response_id, const std::string& query, const std::map<std::string, std::string> & options) {
    // Your implementation goes here
    printf("get\n");
  }

  int32_t openSession(const std::string& site, const std::string& secret_key, const bool staging_mode, const int32_t suggested_session_id) {
    // Your implementation goes here
    printf("openSession\n");
  }

  void resetSite(const std::string& site, const std::string& secret_key) {
    // Your implementation goes here
    printf("resetSite\n");
  }

  void structure(VaeDbStructureResponse& _return, const int32_t session_id, const int32_t response_id) {
    // Your implementation goes here
    printf("structure\n");
  }

  void shortTermCacheGet(std::string& _return, const int32_t session_id, const std::string& key, const int32_t flags) {
    // Your implementation goes here
    printf("shortTermCacheGet\n");
  }

  void shortTermCacheSet(const int32_t session_id, const std::string& key, const std::string& value, const int32_t flags, const int32_t expireInterval) {
    // Your implementation goes here
    printf("shortTermCacheSet\n");
  }

  void longTermCacheGet(std::string& _return, const int32_t session_id, const std::string& key, const int32_t renewExpiry) {
    // Your implementation goes here
    printf("longTermCacheGet\n");
  }

  void longTermCacheSet(const int32_t session_id, const std::string& key, const std::string& value, const int32_t expireInterval, const int32_t isFilename) {
    // Your implementation goes here
    printf("longTermCacheSet\n");
  }

  void longTermCacheEmpty(const int32_t session_id) {
    // Your implementation goes here
    printf("longTermCacheEmpty\n");
  }

};

int main(int argc, char **argv) {
  int port = 9090;
  shared_ptr<VaeDbHandler> handler(new VaeDbHandler());
  shared_ptr<TProcessor> processor(new VaeDbProcessor(handler));
  shared_ptr<TServerTransport> serverTransport(new TServerSocket(port));
  shared_ptr<TTransportFactory> transportFactory(new TBufferedTransportFactory());
  shared_ptr<TProtocolFactory> protocolFactory(new TBinaryProtocolFactory());

  TSimpleServer server(processor, serverTransport, transportFactory, protocolFactory);
  server.serve();
  return 0;
}

