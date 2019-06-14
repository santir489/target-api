Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'api/v1/auth', controllers: {
    registrations: 'api/v1/registrations',  
  }
 
  namespace 'api' do
    namespace 'v1' do
      resources :targets
      resource :user,  only: [:update, :destroy]
    end
  end  
end
