module Api
  module V1
    class ConversationsController < Api::V1::ApiController
      before_action :authenticate_user!

      def index
        @conversations = current_user.conversations
      end

      # api/v1/conversations/:conversation_id/messages
      def messages
        @messages = Conversation.find(params[:conversation_id]).messages
      end
    end
  end
end
