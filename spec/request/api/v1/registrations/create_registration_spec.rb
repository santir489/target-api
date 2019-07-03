require 'rails_helper'

describe 'POST /api/v1/auth', type: :request do
  let(:user) { build(:user) }
  let(:params) do 
    { user: {
        email: user.email,
        password: user.password,
        name: user.name,
        gender: user.gender,
        password_confirmation: user.password } } 
  end


  context 'when request is valid' do
    subject do
      post user_registration_path, params: params, as: :json
    end

    it 'returns a successful response' do
      subject
      expect(response).to be_successful
    end

    it 'sends an email' do         
      expect { subject }.to change { Devise.mailer.deliveries.count }.by(1)
    end

    it 'creates a user' do         
      expect { subject }.to change { User.count }.by(1)
    end

    it 'enques a job to subscribe user' do
      expect { subject }.to have_enqueued_job(SubscribeUserJob)
    end
  end

  context 'when request is not valid' do
    before do
      params[:user][:password_confirmation] = 'Wrong_password'
    end

    subject do
      post user_registration_path, params: params, as: :json
    end

    it 'returns unprocessable entity response' do
      subject
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'returns password confirmation failure message' do
      subject
      expect(json[:status]).to eq('error')
      expect(json[:errors][:password_confirmation]).to include('doesn\'t match Password')
    end
  end  
end
