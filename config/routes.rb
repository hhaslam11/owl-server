Rails.application.routes.draw do
  resources :users, only: [:create, :show] do
    resources :owls, only: [:index]
    resources :letters, only: [:index, :create, :show]
  end

  resources :countries, only: [:show] do
    resources :letters, only: [:index, :show, :update]
  end
end
