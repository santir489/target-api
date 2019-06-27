require 'rails_helper'

describe NotificationService do
  describe '#subscribe_user' do
    let!(:user) { create(:user) }

    subject { NotificationService.subscribe_user(user.email) }
    it 'creates user in onesignal' do
      response = double(body: { id: MockHelper::PLAYER_ID }.to_json)
      expect(OneSignal::Player).to receive(:create).once.and_return(response)
      subject
    end
  end

  describe '#send_notification' do
    subject { NotificationService.send_notification(MockHelper::PLAYER_ID, 'message') }
    it 'sends a notification' do
      expect(OneSignal::Notification).to receive(:create).once
      subject
    end
  end
end
