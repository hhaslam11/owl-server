Rails.application.routes.draw do
  resources :users, only: [:create, :show] do
    resources :owls, only: [:index]
    resources :letters, only: [:index, :create, :show, :update]
  end


  put '/postoffice/:country_code/new' => 'postoffice/letters#update'
  patch '/postoffice/:country_code/new' => 'postoffice/letters#update'

  get '/country' => 'sessions#index'

  get '/country/:country_code' => 'sessions#show'

  post '/login' => 'sessions#create'
end
