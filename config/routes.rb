Rails.application.routes.draw do

  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    root to: 'home#home'
    get 'locale', to: 'application#locale'

  resources :posts do
    get :search, on: :collection

    member do
      delete :remove_attachment
      post :available
      post :set_favorite_post
    end

  end

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

  resource :reservations, only: [:create, :destroy, :edit]

  resources :profile, only: [:index]
end
