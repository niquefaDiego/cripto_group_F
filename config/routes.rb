Rails.application.routes.draw do
  resources :secrets
  root 'application#hello'
  get '/decipher', to: 'secrets#decipher'
end
