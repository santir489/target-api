module Api
  module V1
    class QuestionsController < ApplicationController
      before_action :authenticate_user!

      def create
        current_user.questions.create!(question_params)
      end

      private

      def question_params
        params.require(:question).permit(:message, :email_from)
      end
    end
  end
end
