Rails.application.routes.draw do
  resources :movies, only: [:index,:show] do
    member do
      get 'reservation'
    end
    resources :schedules, only: [] do
      resources :reservations, only: [:new]
    end
  end

  resources :reservations, only: [:create]

  get "sheets", to: "sheets#index"
  
  namespace :admin do
    resources :movies, only: [:index, :new, :create, :edit, :update, :destroy] do
      member do
        get 'schedules/new', to: 'schedules#new'
      end
    end
    resources :schedules, only: [:index, :create, :edit, :update, :destroy]
    resources :reservations
  end

  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "movies#index"
end
