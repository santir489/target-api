class RoomChannel < ApplicationCable::Channel
  # calls when a client connects to the server
  def subscribed
    conversation ? stream_for(conversation) : reject
    conversation&.online_user(current_user)
    conversation&.reset_unread(current_user)
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

    other_user = conversation.other_user(current_user)
    return unless conversation.connected_user(other_user)

    conversation.increase_unread(other_user)
    NotifyMessagesJob.perform_later(other_user)
  end

  def conversation
    Conversation.find_by_id(params[:room_id])
  end
end
