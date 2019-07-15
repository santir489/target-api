module Api
  module V1
    class UsersController < Api::V1::ApiController
      before_action :authenticate_user!

      def show; end

      def update
        current_user.update!(user_params)
        render :show
      end

      private

      def user_params
        params.require(:user).permit(:email, :gender, :name)
      end
    end
  end
end
