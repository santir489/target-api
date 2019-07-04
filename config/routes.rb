Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'api/v1/auth', controllers: {
    registrations: 'api/v1/registrations',
    sessions:  'api/v1/sessions'
  }

  namespace 'api' do
    namespace 'v1' do
      resources :targets, only: %i[index create destroy] do
        collection do
          get :compatibles
        end
      end
      resource :user, only: %i[show update]
      devise_scope :user do
        post 'auth/facebook', to: 'sessions#facebook'
      end
    end
  end
end
