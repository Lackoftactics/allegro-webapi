module Allegro
  module WebApi
    class Client
      END_POINT = 'https://webapi.allegro.pl/service.php?wsdl'

      attr_accessor :user_login, :webapi_key, :local_version, :country_code
      attr_reader :client, :password, :session_handle

      def initialize
        yield self
      end


      def password=(password)
        hash = Digest::SHA256.new.digest(password)
        @password = Base64.encode64(hash)
      end

      def call(operation_name, locals= {})
        client.call(operation_name, locals)
      end

      def login
        start_client
        message =  {user_login: user_login, user_hash_password: password, country_code: country_code, webapi_key: webapi_key, local_version: local_version}
        response = client.call(:do_login_enc, message: message)
        set_session_handle(response)
        self
      end

      def set_session_handle(login_response)
        @session_handle = login_response.body[:do_login_enc_response][:session_handle_part]
      end

      private

      def start_client
        @client = Savon.client do
          ssl_verify_mode :none
          wsdl END_POINT
          log  true
          log_level  :debug
          pretty_print_xml true
          strip_namespaces true
        end
      end
    end
  end
end