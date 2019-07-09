class Conversation < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :conversations_users
  has_many :users, through: :conversations_users

  def self.create_conversation(user1, user2)
    conv = user1.conversations.create!
    user2.conversations << conv
    conv
  end

end
