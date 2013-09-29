#encoding: UTF-8
require 'spec_helper'


describe Allegro::WebApi::Client do

  before do
    @client = Allegro::WebApi::Client.new do |config|
      config.user_login = 'User'
      config.password = 'secret'
      config.webapi_key = '1234'
      config.country_code = 1
      config.local_version = 1234
    end

  end

  it 'creates client with proper params' do
    @client.user_login.must_equal 'User'
    @client.webapi_key.must_equal '1234'
    @client.country_code.must_equal 1
    @client.local_version.must_equal 1234
  end

  it 'hashes password properly' do
    hash = Digest::SHA256.new.digest('secret')
    password = Base64.encode64(hash)

    @client.password.must_equal password
  end

  it 'have setted endpoint' do
    Allegro::WebApi::Client::END_POINT.must_equal 'https://webapi.allegro.pl/service.php?wsdl'
  end

  describe 'login' do
    before do
      @client = Allegro::WebApi::Client.new do |config|
        config.user_login = ENV['USER_LOGIN']
        config.password = ENV['PASSWORD']
        config.webapi_key = ENV['API_KEY']
        config.country_code = ENV['COUNTRY_CODE']
        config.local_version = ENV['LOCAL_VERSION']
      end
    end


    it 'logs in' do
      VCR.use_cassette('login') do
        puts @client.login.body
      end
    end
  end
end