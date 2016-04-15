module Allegro
  module WebApi
    class Client
      extend Forwardable
      END_POINT = 'https://webapi.allegro.pl/service.php?wsdl'.freeze
      SESSION_ERRORS = ['ERR_SESSION_EXPIRED', 'ERR_NO_SESSION'].freeze

      attr_reader :client, :hash_password, :session_handle

      def_delegators :@options, :user_login, :webapi_key, :country_code

      def initialize(options)
        @password = options.password
        @options = options
      end

      def call(operation_name, locals = {})
        raw_data = client.call(operation_name, locals)
      rescue => error
        raise Error.call(error, locals, raw_data) unless session_expired?(error)
        login and retry
      end

      def login
        build_client
        session_handler(client.call(:do_login_enc, message: login_params))
        self
      end

      def journal
        JournalGateway.new(self)
      end

      def personal_data
        @personal_data ||= UserGateway.call(self)
      end

      private

      def session_expired?(error)
        error.respond_to?(:to_hash) &&
          SESSION_ERRORS.include?(error.to_hash.dig(:fault, :faultcode))
      end

      def local_version
        query_statuses = client.call(:do_query_all_sys_status,
                                     message: query_statuses_params)
        query_statuses
          .body[:do_query_all_sys_status_response][:sys_country_status][:item]
          .first[:ver_key]
      end

      def session_handler(response)
        @session_handle ||=
          response.body[:do_login_enc_response][:session_handle_part]
      end

      def build_client
        @client = Savon.client do
          ssl_verify_mode :none
          wsdl END_POINT
          log  false
          log_level :debug
          pretty_print_xml true
          strip_namespaces true
        end
      end

      def hash_password
        hash = Digest::SHA256.new.digest(@password)
        @hash_password = Base64.encode64(hash)
      end

      def query_statuses_params
        {countryId: country_code, webapiKey: webapi_key}
      end

      def login_params
        {
          user_login: user_login,
          user_hash_password: hash_password,
          country_code: country_code,
          webapi_key: webapi_key,
          local_version: local_version,
        }
      end
    end # class Client

    class Error < StandardError
      attr_reader :raw_data, :request_params, :error

      def initialize(opts)
        @error = opts[:error]
        @raw_data = opts[:raw_data]
        @request_params = opts[:request_params]
        super(opts)
      end

      def self.call(error, request_params, raw_data)
        new(error: error, request_params: request_params, raw_data: raw_data)
      end
    end # class Error
  end # module WebApi
end # module Allegro
