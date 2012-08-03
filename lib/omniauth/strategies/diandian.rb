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

      def raw_info
        return @raw_info if @raw_info
        @raw_info['uid'] = access_token.params['uid']
        user_info_response_json = access_token.get('/v1/user/info').parsed
        status = user_info_response_json.fetch('meta', {}).fetch('status')
        raise StandardError 'cannot get user info' unless status == 200
        @raw_info['info'] = user_info_response_json.fetch('response')
        @raw_info['token'] = {
            'token' => access_token.token,
            'refresh_token' => access_token.refresh_token,
            'expires_in' => access_token.expires_in,
            'expires_at' => access_token.expires_at,
            'uid' => access_token.params['uid']
        }
      end
    end
  end
end