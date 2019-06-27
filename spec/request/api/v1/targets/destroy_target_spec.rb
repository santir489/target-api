require 'rails_helper'

describe 'DELETE /api/v1/targets', type: :request do
  let(:user) { create(:user) }
  let!(:target) { create(:target, user: user) }

  context 'when the request is not valid' do
    it 'returns unauthorized response' do
      delete api_v1_target_path(id: target.id), as: :json
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'when the request is valid' do
    subject do
      delete api_v1_target_path(id: target.id), params: target, headers: user.create_new_auth_token, as: :json
    end

    it 'returns a saccessful response' do
      subject
      expect(response).to be_successful
    end

    it 'deletes a target correctly' do
      expect { subject }.to change { Target.count }.by(-1)
    end
  end
end
