require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Diandian < OmniAuth::Strategies::OAuth2
      option :client_options, {
          :site => "https://api.diandian.com",
          :authorize_url => "https://api.diandian.com/oauth/authorize",
          :token_url => "https://api.diandian.com/oauth/token"
      }

      option :token_params, {
          :grant_type => "authorization_code"
      }

      uid {
        raw_info[:uid.to_s]
      }

      extra {
        {
            'raw_info' => raw_info
        }
      }

      def request_phase
        super
      end

      def raw_info
        access_token.get('/v1/')
      end
    end
  end
end