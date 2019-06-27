class FacebookService
  def initialize(access_token)
    @access_token = access_token
  end

  def profile
    @graph = Koala::Facebook::API.new(access_token)
    profile = @graph.get_object("me") 
  end
end
