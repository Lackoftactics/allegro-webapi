require_relative '../lib/allegro/webapi'
require 'minitest'
require 'minitest/spec'
require 'minitest/autorun'
require 'webmock/minitest'
require 'vcr'


VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/dish_cassettes'
  c.hook_into :webmock
end


def set_client
  Allegro::WebApi::Client.new do |config|
    config.user_login = ENV['USER_LOGIN']
    config.password = ENV['PASSWORD']
    config.webapi_key = ENV['API_KEY']
    config.country_code = ENV['COUNTRY_CODE']
    config.local_version = ENV['LOCAL_VERSION']
  end
end  


