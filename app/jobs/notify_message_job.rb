class NotifyMessageJob < ApplicationJob
  queue_as :default

  def perform(user)
    NotificationService.send_notification([user.id_onesignal], I18n.t('notification.chat.messages.unread'))
  end
end
