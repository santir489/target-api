module Api
  module V1
    class SessionsController < DeviseTokenAuth::SessionsController

      def facebook          
        user_params = FacebookService.new(params[:access_token]).profile
        @resource = User.from_provider 'facebook', user_params
        sign_in(:user, @resource)
        new_auth_header = @resource.create_new_auth_token
        response.headers.merge!(new_auth_header)
        render_create_success       
      end  
    end
  end
end
