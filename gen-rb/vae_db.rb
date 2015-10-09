#
# Autogenerated by Thrift Compiler (0.9.2)
#
# DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
#

require 'thrift'
require 'vae_types'

module VaeDb
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

    def closeSession(session_id, secret_key)
      send_closeSession(session_id, secret_key)
      recv_closeSession()
    end

    def send_closeSession(session_id, secret_key)
      send_message('closeSession', CloseSession_args, :session_id => session_id, :secret_key => secret_key)
    end

    def recv_closeSession()
      result = receive_message(CloseSession_result)
      raise result.e unless result.e.nil?
      return
    end

    def createInfo(session_id, response_id, query)
      send_createInfo(session_id, response_id, query)
      return recv_createInfo()
    end

    def send_createInfo(session_id, response_id, query)
      send_message('createInfo', CreateInfo_args, :session_id => session_id, :response_id => response_id, :query => query)
    end

    def recv_createInfo()
      result = receive_message(CreateInfo_result)
      return result.success unless result.success.nil?
      raise result.ie unless result.ie.nil?
      raise result.qe unless result.qe.nil?
      raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, 'createInfo failed: unknown result')
    end

    def data(session_id, response_id)
      send_data(session_id, response_id)
      return recv_data()
    end

    def send_data(session_id, response_id)
      send_message('data', Data_args, :session_id => session_id, :response_id => response_id)
    end

    def recv_data()
      result = receive_message(Data_result)
      return result.success unless result.success.nil?
      raise result.ie unless result.ie.nil?
      raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, 'data failed: unknown result')
    end

    def get(session_id, response_id, query, options)
      send_get(session_id, response_id, query, options)
      return recv_get()
    end

    def send_get(session_id, response_id, query, options)
      send_message('get', Get_args, :session_id => session_id, :response_id => response_id, :query => query, :options => options)
    end

    def recv_get()
      result = receive_message(Get_result)
      return result.success unless result.success.nil?
      raise result.ie unless result.ie.nil?
      raise result.qe unless result.qe.nil?
      raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, 'get failed: unknown result')
    end

    def openSession(site, secret_key, staging_mode, suggested_session_id)
      send_openSession(site, secret_key, staging_mode, suggested_session_id)
      return recv_openSession()
    end

    def send_openSession(site, secret_key, staging_mode, suggested_session_id)
      send_message('openSession', OpenSession_args, :site => site, :secret_key => secret_key, :staging_mode => staging_mode, :suggested_session_id => suggested_session_id)
    end

    def recv_openSession()
      result = receive_message(OpenSession_result)
      return result.success unless result.success.nil?
      raise result.e unless result.e.nil?
      raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, 'openSession failed: unknown result')
    end

    def openSession2(site, secret_key, staging_mode, suggested_session_id)
      send_openSession2(site, secret_key, staging_mode, suggested_session_id)
      return recv_openSession2()
    end

    def send_openSession2(site, secret_key, staging_mode, suggested_session_id)
      send_message('openSession2', OpenSession2_args, :site => site, :secret_key => secret_key, :staging_mode => staging_mode, :suggested_session_id => suggested_session_id)
    end

    def recv_openSession2()
      result = receive_message(OpenSession2_result)
      return result.success unless result.success.nil?
      raise result.e unless result.e.nil?
      raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, 'openSession2 failed: unknown result')
    end

    def resetSite(site, secret_key)
      send_resetSite(site, secret_key)
      recv_resetSite()
    end

    def send_resetSite(site, secret_key)
      send_message('resetSite', ResetSite_args, :site => site, :secret_key => secret_key)
    end

    def recv_resetSite()
      result = receive_message(ResetSite_result)
      raise result.e unless result.e.nil?
      return
    end

    def structure(session_id, response_id)
      send_structure(session_id, response_id)
      return recv_structure()
    end

    def send_structure(session_id, response_id)
      send_message('structure', Structure_args, :session_id => session_id, :response_id => response_id)
    end

    def recv_structure()
      result = receive_message(Structure_result)
      return result.success unless result.success.nil?
      raise result.ie unless result.ie.nil?
      raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, 'structure failed: unknown result')
    end

    def sessionCacheGet(session_id, key)
      send_sessionCacheGet(session_id, key)
      return recv_sessionCacheGet()
    end

    def send_sessionCacheGet(session_id, key)
      send_message('sessionCacheGet', SessionCacheGet_args, :session_id => session_id, :key => key)
    end

    def recv_sessionCacheGet()
      result = receive_message(SessionCacheGet_result)
      return result.success unless result.success.nil?
      raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, 'sessionCacheGet failed: unknown result')
    end

    def sessionCacheSet(session_id, key, value)
      send_sessionCacheSet(session_id, key, value)
      recv_sessionCacheSet()
    end

    def send_sessionCacheSet(session_id, key, value)
      send_message('sessionCacheSet', SessionCacheSet_args, :session_id => session_id, :key => key, :value => value)
    end

    def recv_sessionCacheSet()
      result = receive_message(SessionCacheSet_result)
      return
    end

    def sessionCacheDelete(session_id, key)
      send_sessionCacheDelete(session_id, key)
      recv_sessionCacheDelete()
    end

    def send_sessionCacheDelete(session_id, key)
      send_message('sessionCacheDelete', SessionCacheDelete_args, :session_id => session_id, :key => key)
    end

    def recv_sessionCacheDelete()
      result = receive_message(SessionCacheDelete_result)
      return
    end

    def shortTermCacheGet(session_id, key, flags)
      send_shortTermCacheGet(session_id, key, flags)
      return recv_shortTermCacheGet()
    end

    def send_shortTermCacheGet(session_id, key, flags)
      send_message('shortTermCacheGet', ShortTermCacheGet_args, :session_id => session_id, :key => key, :flags => flags)
    end

    def recv_shortTermCacheGet()
      result = receive_message(ShortTermCacheGet_result)
      return result.success unless result.success.nil?
      raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, 'shortTermCacheGet failed: unknown result')
    end

    def shortTermCacheSet(session_id, key, value, flags, expireInterval)
      send_shortTermCacheSet(session_id, key, value, flags, expireInterval)
      recv_shortTermCacheSet()
    end

    def send_shortTermCacheSet(session_id, key, value, flags, expireInterval)
      send_message('shortTermCacheSet', ShortTermCacheSet_args, :session_id => session_id, :key => key, :value => value, :flags => flags, :expireInterval => expireInterval)
    end

    def recv_shortTermCacheSet()
      result = receive_message(ShortTermCacheSet_result)
      return
    end

    def shortTermCacheDelete(session_id, key)
      send_shortTermCacheDelete(session_id, key)
      recv_shortTermCacheDelete()
    end

    def send_shortTermCacheDelete(session_id, key)
      send_message('shortTermCacheDelete', ShortTermCacheDelete_args, :session_id => session_id, :key => key)
    end

    def recv_shortTermCacheDelete()
      result = receive_message(ShortTermCacheDelete_result)
      return
    end

    def longTermCacheGet(session_id, key, renewExpiry, useShortTermCache)
      send_longTermCacheGet(session_id, key, renewExpiry, useShortTermCache)
      return recv_longTermCacheGet()
    end

    def send_longTermCacheGet(session_id, key, renewExpiry, useShortTermCache)
      send_message('longTermCacheGet', LongTermCacheGet_args, :session_id => session_id, :key => key, :renewExpiry => renewExpiry, :useShortTermCache => useShortTermCache)
    end

    def recv_longTermCacheGet()
      result = receive_message(LongTermCacheGet_result)
      return result.success unless result.success.nil?
      raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, 'longTermCacheGet failed: unknown result')
    end

    def longTermCacheSet(session_id, key, value, expireInterval, isFilename)
      send_longTermCacheSet(session_id, key, value, expireInterval, isFilename)
      recv_longTermCacheSet()
    end

    def send_longTermCacheSet(session_id, key, value, expireInterval, isFilename)
      send_message('longTermCacheSet', LongTermCacheSet_args, :session_id => session_id, :key => key, :value => value, :expireInterval => expireInterval, :isFilename => isFilename)
    end

    def recv_longTermCacheSet()
      result = receive_message(LongTermCacheSet_result)
      return
    end

    def longTermCacheDelete(session_id, key)
      send_longTermCacheDelete(session_id, key)
      recv_longTermCacheDelete()
    end

    def send_longTermCacheDelete(session_id, key)
      send_message('longTermCacheDelete', LongTermCacheDelete_args, :session_id => session_id, :key => key)
    end

    def recv_longTermCacheDelete()
      result = receive_message(LongTermCacheDelete_result)
      return
    end

    def longTermCacheEmpty(session_id)
      send_longTermCacheEmpty(session_id)
      recv_longTermCacheEmpty()
    end

    def send_longTermCacheEmpty(session_id)
      send_message('longTermCacheEmpty', LongTermCacheEmpty_args, :session_id => session_id)
    end

    def recv_longTermCacheEmpty()
      result = receive_message(LongTermCacheEmpty_result)
      return
    end

    def longTermCacheSweeperInfo(session_id)
      send_longTermCacheSweeperInfo(session_id)
      return recv_longTermCacheSweeperInfo()
    end

    def send_longTermCacheSweeperInfo(session_id)
      send_message('longTermCacheSweeperInfo', LongTermCacheSweeperInfo_args, :session_id => session_id)
    end

    def recv_longTermCacheSweeperInfo()
      result = receive_message(LongTermCacheSweeperInfo_result)
      return result.success unless result.success.nil?
      raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, 'longTermCacheSweeperInfo failed: unknown result')
    end

    def sitewideLock(session_id)
      send_sitewideLock(session_id)
      return recv_sitewideLock()
    end

    def send_sitewideLock(session_id)
      send_message('sitewideLock', SitewideLock_args, :session_id => session_id)
    end

    def recv_sitewideLock()
      result = receive_message(SitewideLock_result)
      return result.success unless result.success.nil?
      raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, 'sitewideLock failed: unknown result')
    end

    def sitewideUnlock(session_id)
      send_sitewideUnlock(session_id)
      return recv_sitewideUnlock()
    end

    def send_sitewideUnlock(session_id)
      send_message('sitewideUnlock', SitewideUnlock_args, :session_id => session_id)
    end

    def recv_sitewideUnlock()
      result = receive_message(SitewideUnlock_result)
      return result.success unless result.success.nil?
      raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, 'sitewideUnlock failed: unknown result')
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

    def process_closeSession(seqid, iprot, oprot)
      args = read_args(iprot, CloseSession_args)
      result = CloseSession_result.new()
      begin
        @handler.closeSession(args.session_id, args.secret_key)
      rescue ::VaeDbInternalError => e
        result.e = e
      end
      write_result(result, oprot, 'closeSession', seqid)
    end

    def process_createInfo(seqid, iprot, oprot)
      args = read_args(iprot, CreateInfo_args)
      result = CreateInfo_result.new()
      begin
        result.success = @handler.createInfo(args.session_id, args.response_id, args.query)
      rescue ::VaeDbInternalError => ie
        result.ie = ie
      rescue ::VaeDbQueryError => qe
        result.qe = qe
      end
      write_result(result, oprot, 'createInfo', seqid)
    end

    def process_data(seqid, iprot, oprot)
      args = read_args(iprot, Data_args)
      result = Data_result.new()
      begin
        result.success = @handler.data(args.session_id, args.response_id)
      rescue ::VaeDbInternalError => ie
        result.ie = ie
      end
      write_result(result, oprot, 'data', seqid)
    end

    def process_get(seqid, iprot, oprot)
      args = read_args(iprot, Get_args)
      result = Get_result.new()
      begin
        result.success = @handler.get(args.session_id, args.response_id, args.query, args.options)
      rescue ::VaeDbInternalError => ie
        result.ie = ie
      rescue ::VaeDbQueryError => qe
        result.qe = qe
      end
      write_result(result, oprot, 'get', seqid)
    end

    def process_openSession(seqid, iprot, oprot)
      args = read_args(iprot, OpenSession_args)
      result = OpenSession_result.new()
      begin
        result.success = @handler.openSession(args.site, args.secret_key, args.staging_mode, args.suggested_session_id)
      rescue ::VaeDbInternalError => e
        result.e = e
      end
      write_result(result, oprot, 'openSession', seqid)
    end

    def process_openSession2(seqid, iprot, oprot)
      args = read_args(iprot, OpenSession2_args)
      result = OpenSession2_result.new()
      begin
        result.success = @handler.openSession2(args.site, args.secret_key, args.staging_mode, args.suggested_session_id)
      rescue ::VaeDbInternalError => e
        result.e = e
      end
      write_result(result, oprot, 'openSession2', seqid)
    end

    def process_resetSite(seqid, iprot, oprot)
      args = read_args(iprot, ResetSite_args)
      result = ResetSite_result.new()
      begin
        @handler.resetSite(args.site, args.secret_key)
      rescue ::VaeDbInternalError => e
        result.e = e
      end
      write_result(result, oprot, 'resetSite', seqid)
    end

    def process_structure(seqid, iprot, oprot)
      args = read_args(iprot, Structure_args)
      result = Structure_result.new()
      begin
        result.success = @handler.structure(args.session_id, args.response_id)
      rescue ::VaeDbInternalError => ie
        result.ie = ie
      end
      write_result(result, oprot, 'structure', seqid)
    end

    def process_sessionCacheGet(seqid, iprot, oprot)
      args = read_args(iprot, SessionCacheGet_args)
      result = SessionCacheGet_result.new()
      result.success = @handler.sessionCacheGet(args.session_id, args.key)
      write_result(result, oprot, 'sessionCacheGet', seqid)
    end

    def process_sessionCacheSet(seqid, iprot, oprot)
      args = read_args(iprot, SessionCacheSet_args)
      result = SessionCacheSet_result.new()
      @handler.sessionCacheSet(args.session_id, args.key, args.value)
      write_result(result, oprot, 'sessionCacheSet', seqid)
    end

    def process_sessionCacheDelete(seqid, iprot, oprot)
      args = read_args(iprot, SessionCacheDelete_args)
      result = SessionCacheDelete_result.new()
      @handler.sessionCacheDelete(args.session_id, args.key)
      write_result(result, oprot, 'sessionCacheDelete', seqid)
    end

    def process_shortTermCacheGet(seqid, iprot, oprot)
      args = read_args(iprot, ShortTermCacheGet_args)
      result = ShortTermCacheGet_result.new()
      result.success = @handler.shortTermCacheGet(args.session_id, args.key, args.flags)
      write_result(result, oprot, 'shortTermCacheGet', seqid)
    end

    def process_shortTermCacheSet(seqid, iprot, oprot)
      args = read_args(iprot, ShortTermCacheSet_args)
      result = ShortTermCacheSet_result.new()
      @handler.shortTermCacheSet(args.session_id, args.key, args.value, args.flags, args.expireInterval)
      write_result(result, oprot, 'shortTermCacheSet', seqid)
    end

    def process_shortTermCacheDelete(seqid, iprot, oprot)
      args = read_args(iprot, ShortTermCacheDelete_args)
      result = ShortTermCacheDelete_result.new()
      @handler.shortTermCacheDelete(args.session_id, args.key)
      write_result(result, oprot, 'shortTermCacheDelete', seqid)
    end

    def process_longTermCacheGet(seqid, iprot, oprot)
      args = read_args(iprot, LongTermCacheGet_args)
      result = LongTermCacheGet_result.new()
      result.success = @handler.longTermCacheGet(args.session_id, args.key, args.renewExpiry, args.useShortTermCache)
      write_result(result, oprot, 'longTermCacheGet', seqid)
    end

    def process_longTermCacheSet(seqid, iprot, oprot)
      args = read_args(iprot, LongTermCacheSet_args)
      result = LongTermCacheSet_result.new()
      @handler.longTermCacheSet(args.session_id, args.key, args.value, args.expireInterval, args.isFilename)
      write_result(result, oprot, 'longTermCacheSet', seqid)
    end

    def process_longTermCacheDelete(seqid, iprot, oprot)
      args = read_args(iprot, LongTermCacheDelete_args)
      result = LongTermCacheDelete_result.new()
      @handler.longTermCacheDelete(args.session_id, args.key)
      write_result(result, oprot, 'longTermCacheDelete', seqid)
    end

    def process_longTermCacheEmpty(seqid, iprot, oprot)
      args = read_args(iprot, LongTermCacheEmpty_args)
      result = LongTermCacheEmpty_result.new()
      @handler.longTermCacheEmpty(args.session_id)
      write_result(result, oprot, 'longTermCacheEmpty', seqid)
    end

    def process_longTermCacheSweeperInfo(seqid, iprot, oprot)
      args = read_args(iprot, LongTermCacheSweeperInfo_args)
      result = LongTermCacheSweeperInfo_result.new()
      result.success = @handler.longTermCacheSweeperInfo(args.session_id)
      write_result(result, oprot, 'longTermCacheSweeperInfo', seqid)
    end

    def process_sitewideLock(seqid, iprot, oprot)
      args = read_args(iprot, SitewideLock_args)
      result = SitewideLock_result.new()
      result.success = @handler.sitewideLock(args.session_id)
      write_result(result, oprot, 'sitewideLock', seqid)
    end

    def process_sitewideUnlock(seqid, iprot, oprot)
      args = read_args(iprot, SitewideUnlock_args)
      result = SitewideUnlock_result.new()
      result.success = @handler.sitewideUnlock(args.session_id)
      write_result(result, oprot, 'sitewideUnlock', seqid)
    end

  end

  # HELPER FUNCTIONS AND STRUCTURES

  class Ping_args
    include ::Thrift::Struct, ::Thrift::Struct_Union

    FIELDS = {

    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class Ping_result
    include ::Thrift::Struct, ::Thrift::Struct_Union
    SUCCESS = 0

    FIELDS = {
      SUCCESS => {:type => ::Thrift::Types::BYTE, :name => 'success'}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class CloseSession_args
    include ::Thrift::Struct, ::Thrift::Struct_Union
    SESSION_ID = 1
    SECRET_KEY = 2

    FIELDS = {
      SESSION_ID => {:type => ::Thrift::Types::I32, :name => 'session_id'},
      SECRET_KEY => {:type => ::Thrift::Types::STRING, :name => 'secret_key'}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class CloseSession_result
    include ::Thrift::Struct, ::Thrift::Struct_Union
    E = 1

    FIELDS = {
      E => {:type => ::Thrift::Types::STRUCT, :name => 'e', :class => ::VaeDbInternalError}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class CreateInfo_args
    include ::Thrift::Struct, ::Thrift::Struct_Union
    SESSION_ID = 1
    RESPONSE_ID = 2
    QUERY = 3

    FIELDS = {
      SESSION_ID => {:type => ::Thrift::Types::I32, :name => 'session_id'},
      RESPONSE_ID => {:type => ::Thrift::Types::I32, :name => 'response_id'},
      QUERY => {:type => ::Thrift::Types::STRING, :name => 'query'}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class CreateInfo_result
    include ::Thrift::Struct, ::Thrift::Struct_Union
    SUCCESS = 0
    IE = 1
    QE = 2

    FIELDS = {
      SUCCESS => {:type => ::Thrift::Types::STRUCT, :name => 'success', :class => ::VaeDbCreateInfoResponse},
      IE => {:type => ::Thrift::Types::STRUCT, :name => 'ie', :class => ::VaeDbInternalError},
      QE => {:type => ::Thrift::Types::STRUCT, :name => 'qe', :class => ::VaeDbQueryError}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class Data_args
    include ::Thrift::Struct, ::Thrift::Struct_Union
    SESSION_ID = 1
    RESPONSE_ID = 2

    FIELDS = {
      SESSION_ID => {:type => ::Thrift::Types::I32, :name => 'session_id'},
      RESPONSE_ID => {:type => ::Thrift::Types::I32, :name => 'response_id'}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class Data_result
    include ::Thrift::Struct, ::Thrift::Struct_Union
    SUCCESS = 0
    IE = 1

    FIELDS = {
      SUCCESS => {:type => ::Thrift::Types::STRUCT, :name => 'success', :class => ::VaeDbDataResponse},
      IE => {:type => ::Thrift::Types::STRUCT, :name => 'ie', :class => ::VaeDbInternalError}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class Get_args
    include ::Thrift::Struct, ::Thrift::Struct_Union
    SESSION_ID = 1
    RESPONSE_ID = 2
    QUERY = 3
    OPTIONS = 4

    FIELDS = {
      SESSION_ID => {:type => ::Thrift::Types::I32, :name => 'session_id'},
      RESPONSE_ID => {:type => ::Thrift::Types::I32, :name => 'response_id'},
      QUERY => {:type => ::Thrift::Types::STRING, :name => 'query'},
      OPTIONS => {:type => ::Thrift::Types::MAP, :name => 'options', :key => {:type => ::Thrift::Types::STRING}, :value => {:type => ::Thrift::Types::STRING}}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class Get_result
    include ::Thrift::Struct, ::Thrift::Struct_Union
    SUCCESS = 0
    IE = 1
    QE = 2

    FIELDS = {
      SUCCESS => {:type => ::Thrift::Types::STRUCT, :name => 'success', :class => ::VaeDbResponse},
      IE => {:type => ::Thrift::Types::STRUCT, :name => 'ie', :class => ::VaeDbInternalError},
      QE => {:type => ::Thrift::Types::STRUCT, :name => 'qe', :class => ::VaeDbQueryError}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class OpenSession_args
    include ::Thrift::Struct, ::Thrift::Struct_Union
    SITE = 1
    SECRET_KEY = 2
    STAGING_MODE = 3
    SUGGESTED_SESSION_ID = 4

    FIELDS = {
      SITE => {:type => ::Thrift::Types::STRING, :name => 'site'},
      SECRET_KEY => {:type => ::Thrift::Types::STRING, :name => 'secret_key'},
      STAGING_MODE => {:type => ::Thrift::Types::BOOL, :name => 'staging_mode'},
      SUGGESTED_SESSION_ID => {:type => ::Thrift::Types::I32, :name => 'suggested_session_id'}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class OpenSession_result
    include ::Thrift::Struct, ::Thrift::Struct_Union
    SUCCESS = 0
    E = 1

    FIELDS = {
      SUCCESS => {:type => ::Thrift::Types::STRUCT, :name => 'success', :class => ::VaeDbOpenSessionResponse},
      E => {:type => ::Thrift::Types::STRUCT, :name => 'e', :class => ::VaeDbInternalError}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class OpenSession2_args
    include ::Thrift::Struct, ::Thrift::Struct_Union
    SITE = 1
    SECRET_KEY = 2
    STAGING_MODE = 3
    SUGGESTED_SESSION_ID = 4

    FIELDS = {
      SITE => {:type => ::Thrift::Types::STRING, :name => 'site'},
      SECRET_KEY => {:type => ::Thrift::Types::STRING, :name => 'secret_key'},
      STAGING_MODE => {:type => ::Thrift::Types::BOOL, :name => 'staging_mode'},
      SUGGESTED_SESSION_ID => {:type => ::Thrift::Types::I32, :name => 'suggested_session_id'}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class OpenSession2_result
    include ::Thrift::Struct, ::Thrift::Struct_Union
    SUCCESS = 0
    E = 1

    FIELDS = {
      SUCCESS => {:type => ::Thrift::Types::STRUCT, :name => 'success', :class => ::VaeDbOpenSessionResponse},
      E => {:type => ::Thrift::Types::STRUCT, :name => 'e', :class => ::VaeDbInternalError}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class ResetSite_args
    include ::Thrift::Struct, ::Thrift::Struct_Union
    SITE = 1
    SECRET_KEY = 2

    FIELDS = {
      SITE => {:type => ::Thrift::Types::STRING, :name => 'site'},
      SECRET_KEY => {:type => ::Thrift::Types::STRING, :name => 'secret_key'}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class ResetSite_result
    include ::Thrift::Struct, ::Thrift::Struct_Union
    E = 1

    FIELDS = {
      E => {:type => ::Thrift::Types::STRUCT, :name => 'e', :class => ::VaeDbInternalError}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class Structure_args
    include ::Thrift::Struct, ::Thrift::Struct_Union
    SESSION_ID = 1
    RESPONSE_ID = 2

    FIELDS = {
      SESSION_ID => {:type => ::Thrift::Types::I32, :name => 'session_id'},
      RESPONSE_ID => {:type => ::Thrift::Types::I32, :name => 'response_id'}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class Structure_result
    include ::Thrift::Struct, ::Thrift::Struct_Union
    SUCCESS = 0
    IE = 1

    FIELDS = {
      SUCCESS => {:type => ::Thrift::Types::STRUCT, :name => 'success', :class => ::VaeDbStructureResponse},
      IE => {:type => ::Thrift::Types::STRUCT, :name => 'ie', :class => ::VaeDbInternalError}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class SessionCacheGet_args
    include ::Thrift::Struct, ::Thrift::Struct_Union
    SESSION_ID = 1
    KEY = 2

    FIELDS = {
      SESSION_ID => {:type => ::Thrift::Types::I32, :name => 'session_id'},
      KEY => {:type => ::Thrift::Types::STRING, :name => 'key'}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class SessionCacheGet_result
    include ::Thrift::Struct, ::Thrift::Struct_Union
    SUCCESS = 0

    FIELDS = {
      SUCCESS => {:type => ::Thrift::Types::STRING, :name => 'success'}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class SessionCacheSet_args
    include ::Thrift::Struct, ::Thrift::Struct_Union
    SESSION_ID = 1
    KEY = 2
    VALUE = 3

    FIELDS = {
      SESSION_ID => {:type => ::Thrift::Types::I32, :name => 'session_id'},
      KEY => {:type => ::Thrift::Types::STRING, :name => 'key'},
      VALUE => {:type => ::Thrift::Types::STRING, :name => 'value'}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class SessionCacheSet_result
    include ::Thrift::Struct, ::Thrift::Struct_Union

    FIELDS = {

    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class SessionCacheDelete_args
    include ::Thrift::Struct, ::Thrift::Struct_Union
    SESSION_ID = 1
    KEY = 2

    FIELDS = {
      SESSION_ID => {:type => ::Thrift::Types::I32, :name => 'session_id'},
      KEY => {:type => ::Thrift::Types::STRING, :name => 'key'}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class SessionCacheDelete_result
    include ::Thrift::Struct, ::Thrift::Struct_Union

    FIELDS = {

    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class ShortTermCacheGet_args
    include ::Thrift::Struct, ::Thrift::Struct_Union
    SESSION_ID = 1
    KEY = 2
    FLAGS = 3

    FIELDS = {
      SESSION_ID => {:type => ::Thrift::Types::I32, :name => 'session_id'},
      KEY => {:type => ::Thrift::Types::STRING, :name => 'key'},
      FLAGS => {:type => ::Thrift::Types::I32, :name => 'flags'}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class ShortTermCacheGet_result
    include ::Thrift::Struct, ::Thrift::Struct_Union
    SUCCESS = 0

    FIELDS = {
      SUCCESS => {:type => ::Thrift::Types::STRING, :name => 'success'}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class ShortTermCacheSet_args
    include ::Thrift::Struct, ::Thrift::Struct_Union
    SESSION_ID = 1
    KEY = 2
    VALUE = 3
    FLAGS = 4
    EXPIREINTERVAL = 5

    FIELDS = {
      SESSION_ID => {:type => ::Thrift::Types::I32, :name => 'session_id'},
      KEY => {:type => ::Thrift::Types::STRING, :name => 'key'},
      VALUE => {:type => ::Thrift::Types::STRING, :name => 'value'},
      FLAGS => {:type => ::Thrift::Types::I32, :name => 'flags'},
      EXPIREINTERVAL => {:type => ::Thrift::Types::I32, :name => 'expireInterval'}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class ShortTermCacheSet_result
    include ::Thrift::Struct, ::Thrift::Struct_Union

    FIELDS = {

    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class ShortTermCacheDelete_args
    include ::Thrift::Struct, ::Thrift::Struct_Union
    SESSION_ID = 1
    KEY = 2

    FIELDS = {
      SESSION_ID => {:type => ::Thrift::Types::I32, :name => 'session_id'},
      KEY => {:type => ::Thrift::Types::STRING, :name => 'key'}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class ShortTermCacheDelete_result
    include ::Thrift::Struct, ::Thrift::Struct_Union

    FIELDS = {

    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class LongTermCacheGet_args
    include ::Thrift::Struct, ::Thrift::Struct_Union
    SESSION_ID = 1
    KEY = 2
    RENEWEXPIRY = 3
    USESHORTTERMCACHE = 4

    FIELDS = {
      SESSION_ID => {:type => ::Thrift::Types::I32, :name => 'session_id'},
      KEY => {:type => ::Thrift::Types::STRING, :name => 'key'},
      RENEWEXPIRY => {:type => ::Thrift::Types::I32, :name => 'renewExpiry'},
      USESHORTTERMCACHE => {:type => ::Thrift::Types::I32, :name => 'useShortTermCache'}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class LongTermCacheGet_result
    include ::Thrift::Struct, ::Thrift::Struct_Union
    SUCCESS = 0

    FIELDS = {
      SUCCESS => {:type => ::Thrift::Types::STRING, :name => 'success'}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class LongTermCacheSet_args
    include ::Thrift::Struct, ::Thrift::Struct_Union
    SESSION_ID = 1
    KEY = 2
    VALUE = 3
    EXPIREINTERVAL = 4
    ISFILENAME = 5

    FIELDS = {
      SESSION_ID => {:type => ::Thrift::Types::I32, :name => 'session_id'},
      KEY => {:type => ::Thrift::Types::STRING, :name => 'key'},
      VALUE => {:type => ::Thrift::Types::STRING, :name => 'value'},
      EXPIREINTERVAL => {:type => ::Thrift::Types::I32, :name => 'expireInterval'},
      ISFILENAME => {:type => ::Thrift::Types::I32, :name => 'isFilename'}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class LongTermCacheSet_result
    include ::Thrift::Struct, ::Thrift::Struct_Union

    FIELDS = {

    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class LongTermCacheDelete_args
    include ::Thrift::Struct, ::Thrift::Struct_Union
    SESSION_ID = 1
    KEY = 2

    FIELDS = {
      SESSION_ID => {:type => ::Thrift::Types::I32, :name => 'session_id'},
      KEY => {:type => ::Thrift::Types::STRING, :name => 'key'}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class LongTermCacheDelete_result
    include ::Thrift::Struct, ::Thrift::Struct_Union

    FIELDS = {

    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class LongTermCacheEmpty_args
    include ::Thrift::Struct, ::Thrift::Struct_Union
    SESSION_ID = 1

    FIELDS = {
      SESSION_ID => {:type => ::Thrift::Types::I32, :name => 'session_id'}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class LongTermCacheEmpty_result
    include ::Thrift::Struct, ::Thrift::Struct_Union

    FIELDS = {

    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class LongTermCacheSweeperInfo_args
    include ::Thrift::Struct, ::Thrift::Struct_Union
    SESSION_ID = 1

    FIELDS = {
      SESSION_ID => {:type => ::Thrift::Types::I32, :name => 'session_id'}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class LongTermCacheSweeperInfo_result
    include ::Thrift::Struct, ::Thrift::Struct_Union
    SUCCESS = 0

    FIELDS = {
      SUCCESS => {:type => ::Thrift::Types::STRUCT, :name => 'success', :class => ::VaeDbDataForContext}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class SitewideLock_args
    include ::Thrift::Struct, ::Thrift::Struct_Union
    SESSION_ID = 1

    FIELDS = {
      SESSION_ID => {:type => ::Thrift::Types::I32, :name => 'session_id'}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class SitewideLock_result
    include ::Thrift::Struct, ::Thrift::Struct_Union
    SUCCESS = 0

    FIELDS = {
      SUCCESS => {:type => ::Thrift::Types::I32, :name => 'success'}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class SitewideUnlock_args
    include ::Thrift::Struct, ::Thrift::Struct_Union
    SESSION_ID = 1

    FIELDS = {
      SESSION_ID => {:type => ::Thrift::Types::I32, :name => 'session_id'}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class SitewideUnlock_result
    include ::Thrift::Struct, ::Thrift::Struct_Union
    SUCCESS = 0

    FIELDS = {
      SUCCESS => {:type => ::Thrift::Types::I32, :name => 'success'}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

end

