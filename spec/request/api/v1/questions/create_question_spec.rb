require 'rails_helper'

describe 'POST /api/v1/questions', type: :request do
  let(:user) { create(:user) }
  let(:question) { build(:question, user: user) }
  let(:params) do
    {
      question: {
        email_from: question.email_from,
        message: question.message
      }
    }
  end

  context 'when the user is not logged in' do
    it 'returns unauthorized response' do
      post api_v1_questions_path, params: params, as: :json
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'when request is valid' do
    subject do
      post api_v1_questions_path, params: params, headers: user.create_new_auth_token, as: :json
    end

    it 'returns a successful response' do
      subject
      expect(response).to be_successful
    end

    it 'creates a question with correct attributes' do
      subject
      expect(Question.last).to have_attributes(email_from: question.email_from, message: question.message)
    end

    it 'sends an email' do
      expect { subject }.to have_enqueued_job.on_queue('mailers')
    end
  end
end
