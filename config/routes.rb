Rails.application.routes.draw do
  namespace :admin do
    resources :categories, only: [:index, :new, :create]
  end

  get 'about/index'
  get '/about', to: 'about#index'
  root to: 'products#index'

  resources :products, only: [:index, :show]
  resources :categories, only: [:show]

  resource :cart, only: [:show] do
    post :add_item
    post :remove_item
  end

  resources :orders, only: [:create, :show]

  namespace :admin do
    root to: 'dashboard#show'
    resources :products, except: [:edit, :update, :show]
  end

  # Registration routes
  resources :users, only: [:new, :create]
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  # Session routes
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end