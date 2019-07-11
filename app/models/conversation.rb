class Conversation < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :conversations_users
  has_many :users, through: :conversations_users

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

  def self.create_conversation(user_one, user_two)
    return if conversation_exist(user_one, user_two)

    conv = user_one.conversations.create!
    user_two.conversations << conv
    conv
  end

  def self.conversation_exist(user_one, user_two)
    user_one.conversations.each do |conv|
      return true if conv.users.exists?(user_two.id)
    end
    false
  end

  private

  def conversations_user(user)
    conversations_users.select { |conversations_users| conversations_users.user.id == user.id }.first
  end
end