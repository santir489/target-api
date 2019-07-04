class QuestionMailer < ApplicationMailer
  def contact_administrator
    @question = params[:question]
    mail(from: @question.email_from, to: @question.email_to, subject: 'User question', question: @question)
  end
end
