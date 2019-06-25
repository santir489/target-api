class NotifyCompatiblesJob < ApplicationJob
  queue_as :default
 
  def perform(target)
    list_id_onesignal = User.find(target.compatible_targets.pluck(:user_id)).pluck(:id_onesignal)
    if !list_id_onesignal.empty?
      NotifyCompatible.send_notification(list_id_onesignal,'Hey! You have a new match')
    end
  end
end
