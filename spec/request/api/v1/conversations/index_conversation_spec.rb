require 'rails_helper'

describe 'GET /api/v1/conversations', type: :request do
  let!(:user) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:user3) { create(:user) }
  let!(:conversation) { create(:conversation, :with_users_and_messages, user1: user, user2: user2) }
  let!(:conversation2) { create(:conversation, :with_users, user1: user, user2: user3) }
  let!(:conversation3) { create(:conversation, :with_users, user1: user2, user2: user3) }

  context 'when the request is not valid' do
    it 'returns unauthorized response' do
      get api_v1_conversations_path, as: :json
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'when the request is valid' do
    subject do
      get api_v1_conversations_path, headers: user.create_new_auth_token, as: :json
    end

    it 'returns a successful response' do
      subject
      expect(response).to be_successful
    end

    it 'returns all user conversations' do
      subject
      expect(json[:conversations].pluck(:other_user)).to match_array([user2.id, user3.id])
      expect(json[:conversations].pluck(:unread_messages)).to match_array([0, 5])
    end
  end
end
