require 'rails_helper'

describe 'GET /api/v1/auth/confirmation', type: :request do
  context 'when request is valid' do
    let(:user) { create(:user) }

    subject do
      get user_confirmation_path, params: { confirmation_token: user.confirmation_token }
    end

    it 'does confirm the user account' do
      expect { subject }.to change { user.reload.confirmed? }.from(false).to(true)
    end
  end
end
