require 'rails_helper'

describe NotifyCompatiblesJob, type: :job do
  let(:user) { create(:user) }
  let!(:target) { create(:target, user: user, latitude: 10.00, longitude: 11.00, topic: 'art', length: 500_000) }
  let(:notify_compatible) { NotifyCompatiblesJob.new(target) }

  context 'when there are no targets compatibles' do
    it 'does not notify user' do
      expect(NotificationService).not_to receive(:send_notification)
      notify_compatible.perform(target)
    end
  end

  context 'when there are targets' do
    let(:user2) { create(:user, id_onesignal: MockHelper::PLAYER_ID) }
    let!(:target2) { create(:target, user: user2, latitude: 10.00, longitude: 11.00, topic: 'art', length: 500_000) }

    it 'does notify user' do
      expect(NotificationService).to receive(:send_notification)
        .with([MockHelper::PLAYER_ID], I18n.t('notification.target.compatible.message'))
      notify_compatible.perform(target)
    end
  end
end
