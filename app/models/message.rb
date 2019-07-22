class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  validates :text, presence: true
  validate  :user_in_conversation, on: :create

  after_create_commit { MessageBroadcastJob.perform_later(self) }

  after_create :notify_unread

  private

  def notify_unread
    other_user = conversation.other_user(user)
    return if conversation.connected_user(other_user)

    conversation.increase_unread(other_user)
    NotifyMessageJob.perform_later(other_user)
  end

  def user_in_conversation
    return if conversation.users.include?(user)

    errors.add(:user_in_conversation, I18n.t('api.errors.users.conversation.belong'))
  end
end
