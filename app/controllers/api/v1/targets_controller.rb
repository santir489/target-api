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
