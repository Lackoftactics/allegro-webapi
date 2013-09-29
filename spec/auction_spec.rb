require 'spec_helper'

describe Allegro::WebApi::Auction do

  it 'gets necesary fields for the form offer' do
    VCR.use_cassette('form_fields') do
      client = set_client
      auction = Allegro::WebApi::Auction.new(client.login)
      puts auction.do_get_sell_form_fields
    end
  end
end