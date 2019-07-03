class NotifyCompatiblesJob < ApplicationJob
  queue_as :default

  def perform(target)
    list_id_onesignal = User.find(target.compatible_targets.pluck(:user_id)).pluck(:id_onesignal)
    return if list_id_onesignal.empty?

    NotificationService.send_notification(list_id_onesignal, I18n.t('notification.target.compatible.message'))
  end
end
