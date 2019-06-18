# frozen_string_literal: true

DeviseTokenAuth.setup do |config|
  config.change_headers_on_each_request = false
  config.default_confirm_success_url = ENV['DEVISE_CONFIRM_SUCCESS_URL']
end
