Rails.application.routes.draw do
  devise_for :users
  resources :categories
  resources :posts
  resources :comments, only: [:new, :create]

  root 'posts#index'
end
