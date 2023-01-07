Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  # get 'events/index'
  # resources :events
  # resources :invites

  resources :events do
    resources :invites, only: [:index, :new, :create, :destroy]
  end

  resources :users do
    resources :invites, only: [:show, :edit, :update] do
      member do
        patch :accept
        put :accept
        patch :decline
        put :decline
      end
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "events#index"
end
