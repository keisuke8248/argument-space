Rails.application.routes.draw do
  root 'groups#index'
  resources :groups, only: [:index, :create, :show]

end
