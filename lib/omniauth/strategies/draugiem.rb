require 'digest/md5'
require 'multi_json'
require 'omniauth'
require 'rest_client'

module OmniAuth
  module Strategies
    #
    # Authenticate to draugiem.lv and frype.com and others.
    #
    # @example Basic Rails Usage
    #
    #  Add this to config/initializers/omniauth.rb
    #
    #    Rails.application.config.middleware.use OmniAuth::Builder do
    #      provider :draugiem, 'App id', 'API Key'
    #    end
    #
    # @example Basic Rack example
    #
    #  use Rack::Session::Cookie
    #  use OmniAuth::Strategies::Draugiem, 'App id', 'API Key'
    #
    class Draugiem
      include OmniAuth::Strategy

      args [:app_id, :api_key]

      protected

      def request_phase
        params = {
          :app => options.app_id,
          :redirect => callback_url,
          :hash => Digest::MD5.hexdigest("#{options.api_key}#{callback_url}")
        }
        query_string = params.collect{ |key,value| "#{key}=#{Rack::Utils.escape(value)}" }.join('&')
        redirect "http://api.draugiem.lv/authorize/?#{query_string}"
      end

      def callback_phase
        if request.params['dr_auth_status'] == 'ok' && request.params['dr_auth_code']
          response = RestClient.get('http://api.draugiem.lv/json/', { :params => draugiem_authorize_params(request.params['dr_auth_code']) })
          auth = MultiJson.decode(response.to_s)
          unless auth['error']
            @auth_data = auth
            super
          else
            fail!(auth['error']['code'].to_s,auth["error"]["description"].to_s)
          end
        else
          fail!(:invalid_request)
        end
      rescue Exception => e
        fail!(:invalid_response, e)
      end

      uid { @auth_data['uid'] }

      credentials do
        { 'apikey' => @auth_data['apikey'] }
      end

      info do
        if @auth_data['users'] && @auth_data['users'][@auth_data['uid']]
          user = @auth_data['users'][@auth_data['uid']]
          {
            'name' => "#{user['name']} #{user['surname']}",
            'nickname' => user['nick'],
            'first_name' => user['name'],
            'last_name' => user['surname'],
            'location' => user['place'],
            'age' => user['age'] =~ /^0-9$/ ? user['age'] : nil,
            'adult' => user['adult'] == '1' ? true : false,
            'image' => user['img'],
            'sex' => user['sex']
          }
        else
          {}
        end
      end

      extra do
        { 'user_hash' => @auth_data }
      end

      private

      def draugiem_authorize_params code
        {
          :action => 'authorize',
          :app => options.api_key,
          :code => code
        }
      end
    end
  end
end
