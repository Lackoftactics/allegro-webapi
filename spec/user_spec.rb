require 'spec_helper'


describe Allegro::WebApi::User do

  it 'gets my user data' do
    VCR.use_cassette('my_profile_data') do
      client = set_client
      user = Allegro::WebApi::User.new(client.login)
      user.do_get_my_data.wont_be_nil
    end
  end

  describe 'more specific info' do

    before do
      VCR.use_cassette('my_profile') do
        client = set_client
        @user = Allegro::WebApi::User.new(client.login)
        @user.do_get_my_data
        @user
      end
    end

    it 'gets user first name and last name' do
      @user.first_name.wont_be_nil
      @user.last_name.wont_be_nil
    end

    it 'gets email' do
      @user.email.wont_be_nil
    end

    it 'gets city' do
      @user.city.wont_be_nil
    end

    it 'gets phone' do
      @user.phone.wont_be_nil
    end

    it 'gets rating' do
      @user.rating.wont_be_nil
    end

    it 'gets id' do
      @user.id.wont_be_nil
    end

    it 'gets birth_date' do
      @user.birth_date.wont_be_nil
    end

    it 'gets address' do
      @user.address.wont_be_nil
    end

    it 'gets company' do
      @user.company.wont_be_nil
    end
  end
end