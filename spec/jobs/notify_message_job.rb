require 'rails_helper'

describe NotifyMessageJob, type: :job do
  let(:user) { create(:user, id_onesignal: MockHelper::PLAYER_ID) }
  let(:notify_message) { NotifyMessageJob.new(user) }

  it 'does notify user' do
    expect(NotificationService).to receive(:send_notification)
      .with([MockHelper::PLAYER_ID], I18n.t('notification.chat.messages.unread'))
    notify_message.perform(user)
  end
end
