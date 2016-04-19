# frozen_string_literal: true
require 'savon'
require 'allegro/webapi/version'
require 'allegro/webapi/auction'
require 'allegro/webapi/client'
require 'allegro/webapi/call'
require 'allegro/webapi/user_gateway'
require 'allegro/webapi/journal_gateway'
require 'allegro/webapi/payu_gateway'
require 'allegro/webapi/search'
require 'yaml'

module Allegro
  module WebApi
    Options = Struct.new(:user_login, :password, :webapi_key, :country_code) do
      def self.from_env(opts = {})
        new(
          opts[:user_login] || ENV.fetch('ALLEGRO_USER_LOGIN'),
          opts[:password] || ENV.fetch('ALLEGRO_USER_PASSWORD'),
          opts[:webapi_key] || ENV.fetch('ALLEGRO_WEBAPI_KEY'),
          opts[:country_code] || ENV.fetch('ALLEGRO_COUNTRY_CODE'),
        )
      end
    end # Options = Struct.new
  end # module WebApi
end # module Allegro
