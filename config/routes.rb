Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      # authentication
      post 'authenticate', to: 'authentication#create'

      resources :posts, only: %i[show create] do
        resources :comments, only: :create
      end
    end
  end
end
