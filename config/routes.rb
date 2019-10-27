Rails.application.routes.draw do
  resources :posts do
    post :search, on: :collection
  end
  resources :categories
  root to: 'home#home'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
