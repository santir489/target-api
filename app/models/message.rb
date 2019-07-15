class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  validates :text, :conversation, :user, presence: true

  after_create_commit { MessageBroadcastJob.perform_later(self) }
end
