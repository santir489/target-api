module Api
  module V1
    class SessionsController < DeviseTokenAuth::SessionsController
      protect_from_forgery with: :null_session
      include Concerns::ActAsApiRequest

      def facebook
        user_params = FacebookService.new(params[:access_token]).profile
        @resource = User.from_provider 'facebook', user_params
        sign_in(:user, @resource)
        new_auth_header = @resource.create_new_auth_token
        response.headers.merge!(new_auth_header)
        render_create_success
      rescue Koala::Facebook::AuthenticationError
        render json: { error: 'Invalid OAuth access token' }, status: :unauthorized
      rescue Koala::Facebook::APIError
        render json: { error: 'Unkwon error' }, status: :bad_request
      end
    end
  end
end
