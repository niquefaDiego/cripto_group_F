Rails.application.routes.draw do
  resources :secrets
  #get '/secrets',  to: 'secrets#index'
  root 'application#index'

  #get '/decipher', to: 'secrets#decipher'
end
