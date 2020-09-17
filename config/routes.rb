Rails.application.routes.draw do
  devise_for :users
  root 'groups#index'
  resources :groups, only: [:index, :show, :create] do
    member do
      get :api, defaults: { format: 'json' }
    end
  end
  resources :comments, only: [:create]
  resources :favorites, only: [:create] do
    collection do
      post :api, defaults: { format: 'json' }
    end
  end
end
