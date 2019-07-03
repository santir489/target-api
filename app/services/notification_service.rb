module NotificationService
  extend self

  APP_ID = ENV['ONESIGNAL_APP_ID']

  def subscribe_user(email)
    params = {
      app_id: APP_ID,
      identifier: email,
      device_type: 5 # chrome type
    }
    response = OneSignal::Player.create(params: params)
    
    JSON.parse(response.body)['id']
  end

  def send_notification(users_id, message)
    params = {
      app_id: APP_ID,
      contents: {
        en: message
      },
      include_player_ids: users_id
    }

    OneSignal::Notification.create(params: params)
  end
end
 