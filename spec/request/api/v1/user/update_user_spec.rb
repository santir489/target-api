require 'rails_helper'

describe 'PUT /api/v1/user', :type => :request do 
  
  context 'when the request is not valid' do
    it 'returns unauthorized response' do        
      put api_v1_user_path,  as: :json
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'when the request is valid' do

    let(:user) {create(:user)}

    it 'updates user name' do     
      params= {  user: { name: 'new name' } }
      put api_v1_user_path, params: params, headers: user.create_new_auth_token, as: :json
      expect(user.reload.name).to eq(params[:user][:name])
    end

    it 'updates user email' do     
      params= {  user: { email: 'mail@gmail.com' } }
      put api_v1_user_path, params: params, headers: user.create_new_auth_token, as: :json
      expect(user.reload.email).to eq(params[:user][:email])
    end

  end


end
