Rails.application.routes.draw do
  root 'static_pages#about'
  get '/about', to: 'static_pages#about'
end
