class ConversationsUser < ApplicationRecord
  belongs_to :user
  belongs_to :conversation

  validates :user, :conversation, presence: true
end
