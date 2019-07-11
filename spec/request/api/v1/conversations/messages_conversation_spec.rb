require 'rails_helper'

describe 'GET /api/v1/conversations/:conversation_id/messages', type: :request do
  let!(:user) { create(:user) }

  context 'when the request is not valid' do
    it 'returns unauthorized response' do
      get api_v1_conversation_messages_path(conversation_id: 'invalid_id'), as: :json
      expect(response).to have_http_status(:unauthorized)
    end
  end

  # context 'when the conversation does not exists' do
  #   it 'returns ..... response' do
  #     get api_v1_conversation_messages_path(conversation_id: 'invalid_id'), headers: user.create_new_auth_token, as: :json
  #     expect(response).to have_http_status(:bad_request)
  #   end
  # end

  context 'when the conversation does exists and the request is valid' do
    let!(:user2) { create(:user) }
    let!(:conversation) do
      create(:convarsation_with_users_and_messages,
             user1: user,
             user2: user2,
             user1_messages_count: 1,
             user2_messages_count: 3)
    end

    subject do
      get api_v1_conversation_messages_path(conversation_id: conversation.id), headers: user.create_new_auth_token, as: :json
    end

    it 'returns a successful response' do
      subject
      expect(response).to be_successful
    end

    it 'returns conversation with 4 messages' do
      subject
      expect(json[:messages].length).to eq(4)
      expect(json[:messages].pluck(:user_id)).to match_array([user.id, user2.id, user2.id, user2.id])
    end
  end
end
