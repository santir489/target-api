class FacebookService
  def initialize(access_token)
    @access_token = access_token
  end

  def profile
    Koala::Facebook::API.new(@access_token).get_object('me?fields=gender,name')
  end
end
