Rails.application.routes.draw do
  root 'groups#index'
  resources :groups, only: [:index, :show, :create]
  resources :comments, only: [:create]
end
