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
  resources :favorites, only: [:index, :create, :destroy]
  resources :account_activations, only: [:edit]
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
