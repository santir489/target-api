class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    payload = {
      id: message.id,
      content: message.text,
      user: message.user
    }
    RoomChannel.broadcast_to(message.conversation, payload)
  end
end
