module Api
  module V1
    class RegistrationsController < DeviseTokenAuth::RegistrationsController
      protect_from_forgery with: :exception
      include Concerns::ActAsApiRequest

      private

      def sign_up_params
        params.require(:user).permit(:email, :password, :password_confirmation, :gender, :name)
      end
    end
  end
end
