# OmniAuth Draugiem

[![Continuous Integration status](https://secure.travis-ci.org/mak-it/omniauth-draugiem.svg)](http://travis-ci.org/mak-it/omniauth-draugiem)

OmniAuth strategy for authenticating to draugiem.lv

## Installation

Add this line to your application's Gemfile:

    gem 'omniauth-draugiem'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install omniauth-draugiem

## Usage

Add this to config/initializers/omniauth.rb

    Rails.application.config.middleware.use OmniAuth::Builder do
      provider :draugiem, 'app_id', 'api_key'
    end

## Contributing

1. Fork it ( http://github.com/mak-it/omniauth-draugiem/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
