Rails.application.routes.draw do
  devise_for :users
  resources :categories
  resources :posts
  resources :comments, only: :create

  root 'posts#index'
end
