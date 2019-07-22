# == Schema Information
#
# Table name: messages
#
#  id              :bigint           not null, primary key
#  text            :text
#  conversation_id :bigint           not null
#  user_id         :bigint           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  delegate :email, to: :user, prefix: true

  validates :text, presence: true
  validate  :user_in_conversation, on: :create

  after_create_commit { MessageBroadcastJob.perform_later(self) }

  private

  def user_in_conversation
    return if conversation.users.include?(user)

    errors.add(:user_in_conversation, I18n.t('api.errors.user_not_conversation'))
  end
end
