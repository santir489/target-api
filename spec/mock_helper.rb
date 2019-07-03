module MockHelper
  PLAYER_ID = 'b5e295e6-5b2d-45e7-test-aaaaaaaaaaa'.freeze

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
          headers: { 'Content-Type': 'application/json' }
        )
    end
  end
end
