class Conversation < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :conversations_users, dependent: :destroy
  has_many :users, through: :conversations_users

  validate :uniqueness_users, on: :create

  def other_user(other)
    users.reject { |user| user.id == other.id }.first
  end

  def online_user(user)
    conversations_user(user).online
  end

  def offline_user(user)
    conversations_user(user).offline
  end

  def connected_user(user)
    conversations_user(user).connected
  end

  def increase_unread(user)
    conversations_user(user).increase_unread
  end

  def reset_unread(user)
    conversations_user(user).reset_unread
  end

  def unread_messages(user)
    conversations_user(user).unread_messages
  end

  def self.conversation_exist(users)
    users.first.conversations.each do |conversation|
      return true if conversation.users.exists?(users.second.id)
    end
    false
  end

  private

  def uniqueness_users
    return unless Conversation.conversation_exist(users)

    errors.add(:uniqueness_users, I18n.t('api.errors.users.conversation.create'))
  end

  def conversations_user(user)
    conversations_users.select { |conversations_user| conversations_user.user.id == user.id }.first
  end
end
