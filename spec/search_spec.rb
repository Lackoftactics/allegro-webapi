require 'spec_helper'

describe Allegro::WebApi::Search do

  it 'make simple search' do
    VCR.use_cassette('search_simple') do
      client = set_client
      search = Allegro::WebApi::Search.new(client.login)
      puts search.search_query('ipad')
    end
  end
end