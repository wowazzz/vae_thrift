#
# Autogenerated by Thrift
#
# DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
#

require 'thrift'
require 'vae_types'

module VaeRubyd
  class Client
    include ::Thrift::Client

    def ping()
      send_ping()
      return recv_ping()
    end

    def send_ping()
      send_message('ping', Ping_args)
    end

    def recv_ping()
      result = receive_message(Ping_result)
      return result.success unless result.success.nil?
      raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, 'ping failed: unknown result')
    end

    def fixDocRoot(path)
      send_fixDocRoot(path)
      return recv_fixDocRoot()
    end

    def send_fixDocRoot(path)
      send_message('fixDocRoot', FixDocRoot_args, :path => path)
    end

    def recv_fixDocRoot()
      result = receive_message(FixDocRoot_result)
      return result.success unless result.success.nil?
      raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, 'fixDocRoot failed: unknown result')
    end

    def haml(text)
      send_haml(text)
      return recv_haml()
    end

    def send_haml(text)
      send_message('haml', Haml_args, :text => text)
    end

    def recv_haml()
      result = receive_message(Haml_result)
      return result.success unless result.success.nil?
      raise result.se unless result.se.nil?
      raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, 'haml failed: unknown result')
    end

    def sass(text, load_path)
      send_sass(text, load_path)
      return recv_sass()
    end

    def send_sass(text, load_path)
      send_message('sass', Sass_args, :text => text, :load_path => load_path)
    end

    def recv_sass()
      result = receive_message(Sass_result)
      return result.success unless result.success.nil?
      raise result.se unless result.se.nil?
      raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, 'sass failed: unknown result')
    end

  end

  class Processor
    include ::Thrift::Processor

    def process_ping(seqid, iprot, oprot)
      args = read_args(iprot, Ping_args)
      result = Ping_result.new()
      result.success = @handler.ping()
      write_result(result, oprot, 'ping', seqid)
    end

    def process_fixDocRoot(seqid, iprot, oprot)
      args = read_args(iprot, FixDocRoot_args)
      result = FixDocRoot_result.new()
      result.success = @handler.fixDocRoot(args.path)
      write_result(result, oprot, 'fixDocRoot', seqid)
    end

    def process_haml(seqid, iprot, oprot)
      args = read_args(iprot, Haml_args)
      result = Haml_result.new()
      begin
        result.success = @handler.haml(args.text)
      rescue VaeSyntaxError => se
        result.se = se
      end
      write_result(result, oprot, 'haml', seqid)
    end

    def process_sass(seqid, iprot, oprot)
      args = read_args(iprot, Sass_args)
      result = Sass_result.new()
      begin
        result.success = @handler.sass(args.text, args.load_path)
      rescue VaeSyntaxError => se
        result.se = se
      end
      write_result(result, oprot, 'sass', seqid)
    end

  end

  # HELPER FUNCTIONS AND STRUCTURES

  class Ping_args
    include ::Thrift::Struct

    FIELDS = {

    }

    def struct_fields; FIELDS; end

    def validate
    end

  end

  class Ping_result
    include ::Thrift::Struct
    SUCCESS = 0

    ::Thrift::Struct.field_accessor self, :success
    FIELDS = {
      SUCCESS => {:type => ::Thrift::Types::BYTE, :name => 'success'}
    }

    def struct_fields; FIELDS; end

    def validate
    end

  end

  class FixDocRoot_args
    include ::Thrift::Struct
    PATH = 1

    ::Thrift::Struct.field_accessor self, :path
    FIELDS = {
      PATH => {:type => ::Thrift::Types::STRING, :name => 'path'}
    }

    def struct_fields; FIELDS; end

    def validate
    end

  end

  class FixDocRoot_result
    include ::Thrift::Struct
    SUCCESS = 0

    ::Thrift::Struct.field_accessor self, :success
    FIELDS = {
      SUCCESS => {:type => ::Thrift::Types::BYTE, :name => 'success'}
    }

    def struct_fields; FIELDS; end

    def validate
    end

  end

  class Haml_args
    include ::Thrift::Struct
    TEXT = 1

    ::Thrift::Struct.field_accessor self, :text
    FIELDS = {
      TEXT => {:type => ::Thrift::Types::STRING, :name => 'text'}
    }

    def struct_fields; FIELDS; end

    def validate
    end

  end

  class Haml_result
    include ::Thrift::Struct
    SUCCESS = 0
    SE = 1

    ::Thrift::Struct.field_accessor self, :success, :se
    FIELDS = {
      SUCCESS => {:type => ::Thrift::Types::STRING, :name => 'success'},
      SE => {:type => ::Thrift::Types::STRUCT, :name => 'se', :class => VaeSyntaxError}
    }

    def struct_fields; FIELDS; end

    def validate
    end

  end

  class Sass_args
    include ::Thrift::Struct
    TEXT = 1
    LOAD_PATH = 2

    ::Thrift::Struct.field_accessor self, :text, :load_path
    FIELDS = {
      TEXT => {:type => ::Thrift::Types::STRING, :name => 'text'},
      LOAD_PATH => {:type => ::Thrift::Types::STRING, :name => 'load_path'}
    }

    def struct_fields; FIELDS; end

    def validate
    end

  end

  class Sass_result
    include ::Thrift::Struct
    SUCCESS = 0
    SE = 1

    ::Thrift::Struct.field_accessor self, :success, :se
    FIELDS = {
      SUCCESS => {:type => ::Thrift::Types::STRING, :name => 'success'},
      SE => {:type => ::Thrift::Types::STRUCT, :name => 'se', :class => VaeSyntaxError}
    }

    def struct_fields; FIELDS; end

    def validate
    end

  end

end

