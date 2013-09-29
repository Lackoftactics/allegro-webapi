# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'allegro/webapi/version'

Gem::Specification.new do |spec|
  spec.name          = "allegro-webapi"
  spec.version       = Allegro::Webapi::VERSION
  spec.authors       = ["Przemek Mroczek"]
  spec.email         = ["przemek@codequest.com"]
  spec.description   = %q{Api wrapper for allegro webapi written in ruby. Make it supereasy to interact with allegro api.}
  spec.summary       = %q{API WRAPPER for allegro web api}
  spec.homepage      = "https://github.com/Lackoftactics/allegro-webapi"
  spec.license       = "MIT"

  spec.rubyforge_project = 'allegro-webapi'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]


  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency 'savon', '2.3.0'
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'minitest', '5.0.8'
  spec.add_development_dependency 'vcr', '2.6.0'
  spec.add_development_dependency "rake"
end
