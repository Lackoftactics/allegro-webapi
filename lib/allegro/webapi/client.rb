require 'savon'
module Allegro
  module WebApi
    class Client
      END_POINT = 'https://webapi.allegro.pl/service.php?wsdl'

      attr_accessor :user_login, :webapi_key, :local_version, :country_code
      attr_reader :client, :password
      def initialize
        yield self
      end


      def password=(password)
        hash = Digest::SHA256.new.digest(password)
        @password = Base64.encode64(hash)
      end


      def login
        start_client
        message =  {user_login: user_login, user_hash_password: password, country_code: country_code, webapi_key: webapi_key, local_version: local_version}
        client.call(:do_login_enc, message: message)
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