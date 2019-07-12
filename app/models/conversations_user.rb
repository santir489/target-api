class ConversationsUser < ApplicationRecord
  belongs_to :user
  belongs_to :conversation

  def online
    update(connected: true)
  end

  def offline
    update(connected: false)
  end

  def increase_unread
    update(unread_messages: unread_messages + 1)
  end

  def reset_unread
    update(unread_messages: 0)
  end
end
