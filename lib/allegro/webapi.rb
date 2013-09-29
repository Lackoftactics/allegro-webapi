require "allegro/webapi/version"
require 'allegro/webapi/auction'
require 'allegro/webapi/client'
require 'yaml'


env_file = 'config/local_env.yml'
YAML.load(File.open(env_file)).each do |key, value|
  ENV[key] = value
end if File.exists?(env_file)

module Allegro
  module Webapi
    # Your code goes here...
  end
end
