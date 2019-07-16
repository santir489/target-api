class SubscribeUserJob < ApplicationJob
  queue_as :default

  def perform(user)
    user.update!(id_onesignal: NotificationService.subscribe_user(user.email))
  end
end
