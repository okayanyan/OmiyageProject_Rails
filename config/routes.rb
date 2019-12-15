Rails.application.routes.draw do
  root 'posts#index'
  get '/about', to: 'static_pages#about'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :posts
  resources :follows, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]
end
