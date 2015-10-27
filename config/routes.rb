Rails.application.routes.draw do
  resources :categories
  resources :posts

  root 'posts#index'
end
