class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  validates :text, presence: true
  validate  :user_in_conversation, on: :create

  after_create_commit { MessageBroadcastJob.perform_later(self) }

  private

  def user_in_conversation
    return if conversation.users.include?(user)

    errors.add(:user_in_conversation, I18n.t('api.errors.user_not_conversation'))
  end
end
