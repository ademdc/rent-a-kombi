Rails.application.routes.draw do
  require 'sidekiq/web'
  require 'sidekiq/cron/web'
  Sidekiq::Web.set :session_secret, Rails.application.secrets[:secret_key_base]


  mount Sidekiq::Web => '/sidekiq'
  resources :posts do
    get :search, on: :collection
    delete :remove_attachment, on: :member

  end
  resources :categories
  root to: 'home#home'

  devise_for :users

  resource :slots do
    post :for_post, on: :collection
    post :last_slot, on: :collection
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
