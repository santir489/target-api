class ConversationsUser < ApplicationRecord
  belongs_to :user
  belongs_to :conversation

  validates :user, :conversation, presence: true

  def online
    update(connected: true)
  end

  def offline
    update(connected: false)
  end
end
