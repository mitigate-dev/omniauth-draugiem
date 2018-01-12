require File.expand_path('../../../spec_helper', __FILE__)

describe 'OmniAuth::Strategies::Draugiem', :type => :strategy do

  include OmniAuth::Test::StrategyTestCase

  def strategy
   [OmniAuth::Strategies::Draugiem, '123', "abc"]
  end

  it 'should initialize with api key and app id' do
    expect { OmniAuth::Strategies::Draugiem.new({},'123','abc') }.to_not raise_error
  end

  describe '/auth/draugiem' do

    it 'should redirect to api.draugiem.lv' do
      get '/auth/draugiem'
      expect(last_response).to be_redirect
      expect(last_response.headers['Location']).to match %r{https://api\.draugiem\.lv/authorize/}
    end

    it 'should gather user data after success authorization' do
      stub_request(:get, "https://api.draugiem.lv/json/?action=authorize&app=abc&code=123456").
        to_return(:body => MultiJson.encode({
          'apikey'=>"123456789",
          'uid'=>"100",
          'language'=>"lv",
          'users'=>{
            '100'=>{
              'uid'=>"100",
              'name'=>"John",
              'surname'=>"Lenon",
              'nick'=>"johnybravo",
              'place'=>"Durbe",
              'age'=>"false",
              'adult'=>"1",
              'img'=>"https://4.bp.blogspot.com/_ZmXOoYjxXog/Sg2jby1RFSI/AAAAAAAAE_Q/1LpfjimAz50/s400/JohnnyBravo3.gif",
              'sex'=>"M"
            }
          }
        }))
        get '/auth/draugiem/callback?dr_auth_status=ok&dr_auth_code=123456'
        expect(last_request.env['omniauth.auth']['credentials']['apikey']).to eq "123456789"
        expect(last_request.env['omniauth.auth']['info']['location']).to eq "Durbe"
        expect(last_request.env['omniauth.auth']['info']['age']).to be nil
        expect(last_request.env['omniauth.auth']['info']['adult']).to be true
    end
  end
end
