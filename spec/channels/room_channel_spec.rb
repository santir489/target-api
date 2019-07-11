require 'rails_helper'

describe RoomChannel, type: :channel do
  let!(:user) { create(:user) }
  let!(:conversation) { create(:convarsation_with_users, user1: user) }

  before do
    stub_connection current_user: user
  end

  context 'when subscription is rejected' do
    it 'rejects subscription if room_id is not present' do
      subscribe
      expect(subscription).to be_rejected
    end

    it 'rejects subscription if room_id is not valid' do
      subscribe(room_id: 'invalid_room')
      expect(subscription).to be_rejected
    end
  end

  context 'when subscription is valid' do
    subject do
      subscribe(room_id: conversation.id)
    end

    it 'successfully subscribes' do
      subject
      expect(subscription).to be_confirmed
    end

    it 'connects user to conversations' do
      expect { subject }.to change { conversation.reload.connected_user(user) }.from(false).to(true)
    end

    it 'performs speak' do
      subject
      perform :speak, message: 'content'
      expect(Message.last.text).to eq('content')
    end
  end
end
