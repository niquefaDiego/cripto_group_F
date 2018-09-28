Rails.application.routes.draw do
  resources :secrets
  root 'application#hello'
end
