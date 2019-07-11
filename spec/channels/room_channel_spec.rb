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

    it '#speak' do
      subject
      perform :speak, message: 'content'
      expect(Message.last.text).to eq('content')
      expect(conversation.unread_messages(conversation.other_user(user))).to eq(1)
    end

    context 'when there are unread messages' do
      let!(:conversation2) { create(:convarsation_with_users_and_messages, user1: user) }

      it 'mark as read the unread messages' do
        expect { subscribe(room_id: conversation2.id) }.to change { conversation2.reload.unread_messages(user) }.from(5).to(0)
      end
    end
  end
end
