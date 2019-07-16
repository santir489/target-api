module Api
  module V1
    module Conversations
      class MessagesController < ApplicationController
        before_action :authenticate_user!

        # api/v1/conversations/:conversation_id/messages
        def index
          @messages = current_user.conversations.find(params[:conversation_id]).messages
        end
      end
    end
  end
end
