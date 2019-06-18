require 'rails_helper'

describe 'GET /api/v1/auth/confirmation', type: :request do
    let(:user) { create(:user, { password: 'password' } ) }

    it 'returns the user is not confirmed' do
      expect(user.confirmed?).to be false
    end

    it 'returns that a confirmation email was sent' do
      post user_session_path, params: {email: user.email, password: "password"}, as: :json
      expect(json[:success]).to be false
      expect(json[:errors]).to include(I18n.t('devise_token_auth.sessions.not_confirmed', email: user.email))
    end

    it 'returns the user is confirmed' do
      get user_confirmation_path, params: { confirmation_token: user.confirmation_token}
      expect(user.reload.confirmed?).to be true
    end
end
