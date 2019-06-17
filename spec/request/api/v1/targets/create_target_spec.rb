require 'rails_helper'

describe 'POST /api/v1/targets', type: :request do  
  let(:user) { create(:user) }
  let(:target) { attributes_for(:target, user: user) }

  context 'when the request is not valid' do
    it 'returns unauthorized response' do     
      post api_v1_targets_path, as: :json
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'when the request is valid' do

    subject do
      post api_v1_targets_path, params:target ,headers: user.create_new_auth_token, as: :json
    end

    it 'returns a successful response' do     
      subject
      expect(response).to be_successful
    end
    
    it 'creates a target with correct attributes' do     
      subject     
      expect(Target.last).to have_attributes target
    end

    it 'creates a target with incorrect attributes' do
      target[:length]=nil   
      subject  
      expect(response).to have_http_status(:bad_request)
    end

    context 'when user target maximum was already reached' do

      before(:each) do        
        create_list(:target, 10, user: user)
      end      

      it 'returns bad_request response' do     
        subject
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
