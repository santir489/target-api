require 'rails_helper'

describe RoomChannel, type: :channel do
  let!(:user) { create(:user) }
  let!(:conversation) { create(:conversation) }

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
    it 'successfully subscribes' do
      subscribe(room_id: conversation.id)
      expect(subscription).to be_confirmed
    end

    it 'performs speak' do
      subscribe(room_id: conversation.id)
      perform :speak, message: 'content'
      expect(Message.last.text).to eq('content')
    end
  end
end
