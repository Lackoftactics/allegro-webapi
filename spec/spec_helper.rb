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



