module Api
  module V1
    class TargetsController < ApplicationController
      before_action :authenticate_user!
      helper_method :target

      def index
        @targets = current_user.targets
      end

      def create
        @target = current_user.targets.create!(target_params)
        @target.compatible_targets.each do |target|
          users = [current_user, target.user]
          Conversation.create!(users: users) unless Conversation.conversation_exist(users)
        end
      end

      def compatibles
        @targets = current_user.targets_match
        render :index
      end

      def destroy
        target.destroy
      end

      private

      def target
        @target ||= Target.find(params[:id])
      end

      def target_params
        params.require(:target).permit(:title, :topic, :latitude, :longitude, :length)
      end
    end
  end
end
