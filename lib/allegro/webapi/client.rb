
module Allegro
  module WebApi
    class Client
      attr_accessor :user_login, :password, :webapi_key, :local_version, :country_code
      def initialize
        yield self
      end
    end
  end
end