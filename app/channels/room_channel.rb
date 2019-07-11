class RoomChannel < ApplicationCable::Channel
  # calls when a client connects to the server
  def subscribed
    conversation ? stream_for(conversation) : reject
    conversation&.online_user(current_user)
  end

  def unsubscribed
    conversation&.offline_user(current_user)
  end

  def speak(data)
    message = data['message']
    raise 'No message!' if message.blank?

    Message.create!(
      conversation: conversation,
      user: current_user,
      text: message
    )
  end

  def conversation
    Conversation.find_by_id(params[:room_id])
  end
end