require 'rails_helper'

describe 'GET /api/v1/targets/compatibles', type: :request do
  let(:user) { create(:user) }
  let!(:target) { create(:target, user: user, latitude: 10.00, longitude: 11.00, topic: 'art', length: 500.000) }

  context 'when the request is not valid' do
    it 'returns unauthorized response' do
      get compatibles_api_v1_targets_path, as: :json
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'when there are targets compatibles' do
    let(:user2) { create(:user) }
    let!(:target2) { create(:target, user: user2, latitude: 10.00, longitude: 11.00, topic: 'art') }
    let!(:target3) { create(:target, user: user2, latitude: 10.00, longitude: 11.00, topic: 'football') }
    let!(:target4) { create(:target, user: user2, latitude: 11.00, longitude: 12.00, topic: 'art', length: 500.000) }
    let!(:target5) { create(:target, user: user2, latitude: 110.00, longitude: 120.00, topic: 'art', length: 5) }

    subject do
      get compatibles_api_v1_targets_path, headers: user.create_new_auth_token, as: :json
    end

    it 'returns a successful response' do
      subject
      expect(response).to be_successful
    end

    it 'returns two targets compatibles' do
      subject
      expect(json[:targets].length).to eq(2)
      expect(json[:targets].pluck(:id)).to match_array([target4.id, target2.id])
    end
  end

  context 'when there are no targets compatibles' do
    let(:user2) { create(:user) }
    let!(:target3) { create(:target, user: user2, latitude: 10.00, longitude: 11.00, topic: 'football') }
    let!(:target4) { create(:target, user: user2, latitude: 11.00, longitude: 12.00, topic: 'music', length: 500) }

    subject do
      get compatibles_api_v1_targets_path, headers: user.create_new_auth_token, as: :json
    end

    it 'returns two targets compatibles' do
      subject
      expect(json[:targets]).to be_empty
    end
  end
end
