Rails.application.routes.draw do
  devise_for :users
  root 'groups#index'
  resources :groups, only: [:index, :show, :create]
  resources :comments, only: [:create]
  resources :favorites, only: [:create]
end
