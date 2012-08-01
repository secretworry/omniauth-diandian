module OmniAuth
  module Strategies
    class Diandian < OmniAuth::Strategies::OAuth2
      option :name, "diandian"

      option :client_options, {
          :site => "https://api.diandian.com/"
      }

      option :token_params, {
      }

      uid {
        raw_info['uid']
      }

      info {
        raw_info['info']
      }

      extra {
        {
            'raw_info' => raw_info
        }
      }

      def request_phase
        redirect client.auth_code.authorize_url({:redirect_url => callback_url}).merge(authorize_params)
      end

      def raw_info
        return @raw_info if @raw_info
        @raw_info['uid'] = access_token.params['uid']
        @raw_info['info'] = access_token.get('/v1/user/info').parsed
        @raw_info['token'] = {
            'token' => access_token.refresh_token,
            'refresh_token' => access_token.refresh_token,
            'expires_in' => access_token.expires_in,
            'expires_at' => access_token.expires_at,
            'uid' => access_token.params['uid']
        }
      end
    end
  end
end