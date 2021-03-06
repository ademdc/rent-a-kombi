Rails.application.routes.draw do

  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    root to: 'home#home'
    get 'locale', to: 'application#locale'

    namespace :api, defaults: { format: :json } do
      namespace :v1 do
        resources :users
        resources :sessions
        resources :registrations, only: [:create]

        resources :posts do
          collection do
            get :search
            delete :delete_favorite_post
          end
        end

      end
    end

    resources :posts do

      collection do
        get :search
        delete :delete_favorite_post
      end

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

    devise_for :users, controllers: {
      registrations: 'users/registrations',
      confirmations: 'users/confirmations'
    }

    resource :slots, only: [:create, :destroy] do
      post :for_post, on: :collection
    end

    resources :conversations do
      resources :messages
    end


    resource :reservations, only: [:create, :destroy, :update] do
      post :for_post, on: :collection
      post :confirm, on: :collection
    end

    resources :profile, only: [:index]

    resources :users, only: [:show], param: :slug
  end
end
