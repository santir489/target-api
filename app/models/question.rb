class Question < ApplicationRecord
  belongs_to :user

  delegate :name, to: :user, prefix: true

  validates :message, :email_from, presence: true

  before_create :pre_create
  after_create :send_question

  private

  def pre_create
    self.email_to = ENV['CONTACT_ADMINISTRATOR_EMAIL']
    self.sent = false
  end

  def send_question
    QuestionMailer.with(question: self).contact_administrator.deliver_later
  end
end
