Rails.application.routes.draw do
  root 'groups#index'
  resources :groups, only: [:index, :create, :show] do
    resources :comments, only: [:index, :create]
  end
end
