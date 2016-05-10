// This autogenerated skeleton file illustrates how to build a server.
// You should copy it to another filename to avoid overwriting it.

#include "VaeRubyd.h"
#include <thrift/protocol/TBinaryProtocol.h>
#include <thrift/server/TSimpleServer.h>
#include <thrift/transport/TServerSocket.h>
#include <thrift/transport/TBufferTransports.h>

using namespace ::apache::thrift;
using namespace ::apache::thrift::protocol;
using namespace ::apache::thrift::transport;
using namespace ::apache::thrift::server;

using boost::shared_ptr;

class VaeRubydHandler : virtual public VaeRubydIf {
 public:
  VaeRubydHandler() {
    // Your initialization goes here
  }

  int8_t ping() {
    // Your implementation goes here
    printf("ping\n");
  }

  int8_t fixDocRoot(const std::string& path) {
    // Your implementation goes here
    printf("fixDocRoot\n");
  }

  void haml(std::string& _return, const std::string& text) {
    // Your implementation goes here
    printf("haml\n");
  }

  void sass(std::string& _return, const std::string& text, const std::string& load_path, const std::string& style) {
    // Your implementation goes here
    printf("sass\n");
  }

  void scss(std::string& _return, const std::string& text, const std::string& load_path, const std::string& style) {
    // Your implementation goes here
    printf("scss\n");
  }

};

int main(int argc, char **argv) {
  int port = 9090;
  shared_ptr<VaeRubydHandler> handler(new VaeRubydHandler());
  shared_ptr<TProcessor> processor(new VaeRubydProcessor(handler));
  shared_ptr<TServerTransport> serverTransport(new TServerSocket(port));
  shared_ptr<TTransportFactory> transportFactory(new TBufferedTransportFactory());
  shared_ptr<TProtocolFactory> protocolFactory(new TBinaryProtocolFactory());

  TSimpleServer server(processor, serverTransport, transportFactory, protocolFactory);
  server.serve();
  return 0;
}

