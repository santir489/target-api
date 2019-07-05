class FacebookService
  attr_reader :client

  def initialize(access_token)
    @client = Koala::Facebook::API.new(access_token)
  end

  def profile
    client.get_object('me?fields=gender,name')
  end
end
