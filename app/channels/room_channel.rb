class RoomChannel < ApplicationCable::Channel
  # calls when a client connects to the server
  def subscribed
    stream_for conversation if params[:room_id].present?
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
