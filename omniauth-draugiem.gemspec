# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth-draugiem/version'

Gem::Specification.new do |s|
  s.name          = "omniauth-draugiem"
  s.version       = Omniauth::Draugiem::VERSION
  s.authors       = ["Edgars Beigarts", "Uldis Ziņģis"]
  s.email         = ["edgars.beigarts@makit.lv", "uldis.zingis@makit.lv"]
  s.summary       = "Draugiem.lv authentication strategy for OmniAuth"
  s.description   = s.summary
  s.homepage      = "http://github.com/mak-it/omniauth-draugiem"
  s.license       = "MIT"

  s.files         = `git ls-files`.split($/)
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^spec/})
  s.require_paths = ["lib"]

  s.add_runtime_dependency "omniauth", "~> 1.0"
  s.add_runtime_dependency "rest-client", "~> 2.0.1"
  s.add_runtime_dependency "multi_json", "~> 1.0"

  s.add_development_dependency "bundler", "~> 1.5"
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec", "~> 3.0"
  s.add_development_dependency "simplecov"
  s.add_development_dependency "rack-test"
  s.add_development_dependency 'webmock'
end
