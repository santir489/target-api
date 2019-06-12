require 'rails_helper'

RSpec.describe " POST /api/v1/targets", :type => :request do  

  

  let(:user) { create(:user) }
  
  let(:target) { attributes_for(:target, user: user) }


  
  context 'when the request is not valid' do

    it 'it returns unauthorized response' do     
      get api_v1_targets_path, as: :json
      expect(response).to have_http_status(:unauthorized)
    end

  end


  context 'when the request is valid' do

    it 'it returns a saccessful response' do     
      post api_v1_targets_path, params:target ,headers: user.create_new_auth_token, as: :json
      expect(response).to have_http_status(:success)
    end
    

    it 'it creates a target whit correct attributes' do     
      post api_v1_targets_path, params:target ,headers: user.create_new_auth_token, as: :json     
      expect(Target.last).to have_attributes target
    end

    it 'it creates a target whit incorrect attributes' do
      target[:length]=nil   
      post api_v1_targets_path, params:target ,headers: user.create_new_auth_token, as: :json  
        
      expect(response).to have_http_status(:bad_request)
    end

   

  end
   

end