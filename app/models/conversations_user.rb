# == Schema Information
#
# Table name: conversations_users
#
#  id              :bigint           not null, primary key
#  user_id         :bigint           not null
#  conversation_id :bigint           not null
#  connected       :boolean          default(FALSE), not null
#  unread_messages :integer          default(0), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

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
