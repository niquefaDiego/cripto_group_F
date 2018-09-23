Rails.application.routes.draw do
  root 'application#hello'
  get '/des', to: 'static_pages#des'
end
