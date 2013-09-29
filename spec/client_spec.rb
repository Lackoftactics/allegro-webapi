require 'spec_helper'


describe Allegro::WebApi::Client do

  it 'creates client with proper params' do
    client = Allegro::WebApi::Client.new do |config|
      config.user_login = 'User'
      config.password = 'secret'
      config.webapi_key = '1234'
      config.country_code = 1
      config.local_version = 1234
    end

    client.user_login.must_equal 'User'
    client.password.must_equal 'secret'
    client.webapi_key.must_equal '1234'
    client.country_code.must_equal 1
    client.local_version.must_equal 1234
  end




end