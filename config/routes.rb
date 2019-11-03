Rails.application.routes.draw do

  root to: 'home#home'

  resources :posts do
    get :search, on: :collection
    delete :remove_attachment, on: :member
  end

  resources :categories

  devise_for :users, controllers: { registrations: 'users/registrations' }

  resource :slots, only: [:create, :destroy] do
    post :for_post, on: :collection
  end

  resources :conversations do
    resources :messages
  end
end
