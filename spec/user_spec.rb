require 'spec_helper'


describe Allegro::WebApi::User do
  before do

  end

  it 'gets my user data' do
    VCR.use_cassette('my_profile_data') do
      client = set_client
      @user = Allegro::WebApi::User.new(client.login)
      puts @user.do_get_my_data
    end

  end


end