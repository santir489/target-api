# == Schema Information
#
# Table name: questions
#
#  id         :bigint           not null, primary key
#  message    :text             not null
#  email_from :text             not null
#  email_to   :text             not null
#  sent       :boolean          default(FALSE), not null
#  user_id    :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Question < ApplicationRecord
  belongs_to :user

  delegate :name, to: :user, prefix: true

  validates :message, :email_from, presence: true
  validates :email_from, format: { with: Devise.email_regexp }

  before_create :pre_create
  after_create :send_question

  private

  def pre_create
    self.email_to = ENV['CONTACT_ADMINISTRATOR_EMAIL']
  end

  def send_question
    QuestionMailer.with(question: self).contact_administrator.deliver_later
  end
end
