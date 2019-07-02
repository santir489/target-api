require 'rails_helper'

describe 'POST /api/v1/auth/facebook', type: :request do
  subject do
    post api_v1_auth_facebook_path, params: param, as: :json
  end

  context 'when the request is not valid' do
    let(:param) do
      { access_token: 'invalid-token' }
    end

    it 'returns a unauthorized response' do
      #WebMock.allow_net_connect!
      subject
      expect(response).to have_http_status(:unauthorized)
      expect(json[:error]).to eq('Invalid OAuth access token')
    end

    it 'does not create user' do
      WebMock.allow_net_connect!
      expect { subject }.to change { User.count }.by(0)
    end
  end

  context 'when the request is valid' do
    let(:param) do
      { access_token: '123456789' }
    end

    it 'returns a successful response' do
      subject
      expect(response).to be_successful
    end

    it 'does create user' do
      expect { subject }.to change { User.count }.by(1)
    end

    it 'assign parameters correctly' do
      subject
      expect(User.last).to have_attributes(
        uid: MockHelper::FACEBOOK_USER_ID,
        name: MockHelper::FACEBOOK_USER_NAME,
        gender: MockHelper::FACEBOOK_USER_GENDER,
        provider: 'facebook'
      )
    end
  end
end
