Rails.application.routes.draw do
  resources :secrets
  resources :users, only: [:new, :create, :edit, :update, :show, :index]
  #get '/secrets',  to: 'secrets#index'
  root 'application#index'

  #get '/decipher', to: 'secrets#decipher'

  get    '/signup',  to: 'users#new'
  post   '/signup',  to: 'users#create'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources :conversations do
    resources :messages
  end

  #resources :conversations

end
