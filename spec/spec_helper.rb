require 'simplecov'
SimpleCov.start do
  add_filter '/vendor/bundle/'
end

require 'rspec'
require 'rack/test'
require 'webmock/rspec'
require 'omniauth-draugiem'
require 'omniauth'

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include WebMock::API
end
