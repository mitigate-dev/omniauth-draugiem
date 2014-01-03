# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth/draugiem/version'

Gem::Specification.new do |s|
  s.name          = "omniauth-draugiem"
  s.version       = Omniauth::Draugiem::VERSION
  s.authors       = ["Edgars Beigarts"]
  s.email         = ["edgars.beigarts@makit.lv"]
  s.summary       = "Draugiem.lv authentication strategy for OmniAuth"
  s.description   = spec.summary
  s.homepage      = ""
  s.license       = "MIT"

  s.files         = `git ls-files`.split($/)
  s.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]

  s.add_runtime_dependency "omniauth"
  s.add_runtime_dependency "canonix"

  s.add_development_dependency "bundler", "~> 1.5"
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
  s.add_development_dependency "simplecov"
  s.add_development_dependency "rack-test"
end
