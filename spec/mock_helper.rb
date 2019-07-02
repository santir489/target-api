module MockHelper
  PLAYER_ID = 'b5e295e6-5b2d-45e7-test-aaaaaaaaaaa'.freeze
  FACEBOOK_ACCESS_TOKEN = '123456789'.freeze
  FACEBOOK_INVALID_ACCESS_TOKEN = '111111111'.freeze
  FACEBOOK_INVALID_ACCESS_TOKEN_ERROR_TYPE = 'OAuthException'.freeze
  FACEBOOK_INVALID_ACCESS_TOKEN_ERROR_CODE = '190'.freeze
  FACEBOOK_USER_ID = '11111111111111111'.freeze
  FACEBOOK_USER_NAME = 'John Doe'.freeze
  FACEBOOK_USER_GENDER = 'male'.freeze

  RSpec.configure do |config|
    config.before :each do
      stub_request(:post, 'https://onesignal.com/api/v1/notifications')
        .to_return(
          status: 200,
          headers: { 'Content-Type': 'application/json' }
        )

      stub_request(:post, 'https://onesignal.com/api/v1/players')
        .to_return(
          body: {
            id: PLAYER_ID,
            object: 'customer'
          }.to_json,
          status: 200,
          headers: { 'Content-Type': 'application/json' })

      stub_request(:get, 'https://graph.facebook.com/me')
        .with(query: hash_including(access_token: FACEBOOK_ACCESS_TOKEN, fields: 'gender,name'))
        .to_return(
          body: {
            id: FACEBOOK_USER_ID,
            name: FACEBOOK_USER_NAME,
            gender: FACEBOOK_USER_GENDER
          }.to_json,
          status: 200
        )

      stub_request(:get, 'https://graph.facebook.com/me')
        .with(query: hash_including(access_token: FACEBOOK_INVALID_ACCESS_TOKEN, fields: 'gender,name'))
        .to_return(
          body: {
            error: {
              type: FACEBOOK_INVALID_ACCESS_TOKEN_ERROR_TYPE,
              code: FACEBOOK_INVALID_ACCESS_TOKEN_ERROR_CODE
            }
          }.to_json,
          status: 400
        )
    end
  end
end
