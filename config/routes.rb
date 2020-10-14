Rails.application.routes.draw do
  devise_for :users
  root 'articles#index'
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
  resources :articles, only: [:index, :show] do
    resources :article_comments, only: [:index, :create] do
      collection do
        get :index10
        get :api, defaults: {format: 'json'}
      end
    end
  end
  resources :evaluations do
    collection do 
      post :good
      post :bad
      post :canceling_good
      post :canceling_bad
    end
  end
end
