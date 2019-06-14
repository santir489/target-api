require 'rails_helper'

describe 'GET /api/v1/targets', :type => :request do    
  let(:user) { create(:user) }
  let!(:targets) do
    create_list(:target, 5, user: user)
  end 

  it 'returns unauthorized response' do     
    get api_v1_targets_path, as: :json
    expect(response).to have_http_status(:unauthorized)
  end

  context 'when the request is valid' do

    subject do
      get api_v1_targets_path, headers: user.create_new_auth_token, as: :json
    end

    it 'returns a saccessful response' do     
      subject
      expect(response).to be_successful
    end

    it 'returns all the targets' do     
      subject          
      expect(json[:targets].map {|target| target[:title] }).to match_array(targets.pluck(:title))      
    end
  end  
end
