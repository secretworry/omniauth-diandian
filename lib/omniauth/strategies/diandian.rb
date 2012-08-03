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

      def callback_url
        options.redirect_uri || super
      end

      def callback_phase
        if request.params['error'] || request.params['error_reason']
          raise CallbackError.new(request.params['error'], request.params['error_description'] || request.params['error_reason'], request.params['error_uri'])
        end
        #if request.params['state'].to_s.empty? || request.params['state'] != session.delete('omniauth.state')
        #  raise CallbackError.new(nil, :csrf_detected)
        #end

        self.access_token = build_access_token
        self.access_token = access_token.refresh! if access_token.expired?

        super
      rescue ::OAuth2::Error, CallbackError => e
        fail!(:invalid_credentials, e)
      rescue ::MultiJson::DecodeError => e
        fail!(:invalid_response, e)
      rescue ::Timeout::Error, ::Errno::ETIMEDOUT => e
        fail!(:timeout, e)
      rescue ::SocketError => e
        fail!(:failed_to_connect, e)
      end

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