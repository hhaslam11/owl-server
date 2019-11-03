Rails.application.routes.draw do
  resources :users, only: [:create, :show] do
    resources :owls, only: [:index]
    resources :letters, only: [:index, :create, :show, :update]
  end

  
  put '/postoffice/:country_id/new' => 'postoffice/letters#update'
  patch '/postoffice/:country_id/new' => 'postoffice/letters#update'

  get '/country' => 'sessions#index'

  post '/login' => 'sessions#create'
end
