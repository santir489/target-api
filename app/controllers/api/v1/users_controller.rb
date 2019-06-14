module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate_user!
      
      def show
        current_user 
      end

      def update
        current_user.update!(user_param) 
      end

      def destroy      
        current_user.destroy               
      end

      private 

      def user_param
        params.require(:user).permit(:email, :gender, :name) 
      end

    end
  end
end
