Rails.application.routes.draw do

  root to: 'home#home'

  resources :posts do
    get :search, on: :collection

    member do
      delete :remove_attachment
      post :available
      post :set_favorite_post
    end

  end

  resources :categories

  devise_for :users, controllers: { registrations: 'users/registrations' }

  resource :slots, only: [:create, :destroy] do
    post :for_post, on: :collection
  end

  resources :conversations do
    resources :messages
  end

  resource :reservations, only: [:create, :destroy, :edit]
end
