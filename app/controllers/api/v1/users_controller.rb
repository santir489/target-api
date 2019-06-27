module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate_user!

      def show; end

      def update
        current_user.update!(user_params)
        render :show
      end

<<<<<<< HEAD
      private
=======
      def facebook
        user_params = FacebookService.new(params[:access_token]).profile
        puts '------------- KOALA -------------------- KOALA -------------------- KOALA ---------'
      end

      private 
>>>>>>> wip

      def user_params
        params.require(:user).permit(:email, :gender, :name)
      end
    end
  end
end
