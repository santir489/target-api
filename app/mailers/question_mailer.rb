class QuestionMailer < ApplicationMailer
  after_action :confirm_send

  # :reek:FeatureEnvy
  def contact_administrator
    @question = params[:question]
    mail(from: @question.email_from, to: @question.email_to, subject: 'User question', question: @question)
  end

  private

  def confirm_send
    @question.update!(sent: true)
  end
end
