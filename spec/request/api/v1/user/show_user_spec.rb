require 'rails_helper'

describe 'GET /api/v1/user', type: :request do
  context 'when the request is not valid' do
    it 'returns unauthorized response' do
      get api_v1_user_path,  as: :json
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'when the request is valid' do
    let(:user) { create(:user) }

    subject do
      get api_v1_user_path, headers: user.create_new_auth_token, as: :json
    end

    it 'returns a successful response' do
      subject
      expect(response).to be_successful
    end

    it 'returns the user logged in' do
      subject
      expect(json[:user][:id]).to eq(user.id)
    end
  end
end
