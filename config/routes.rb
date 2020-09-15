Rails.application.routes.draw do
  devise_for :users
  root 'groups#index'
  resources :groups, only: [:index, :show, :create]
  resources :comments, only: [:create, :update]
  resources :favorites, only: [:create, :update]
end
