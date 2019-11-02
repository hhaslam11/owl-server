Rails.application.routes.draw do
  resources :users, only: [:create, :show] do
    resources :owls, only: [:index]
    resources :letters, only: [:index, :create, :show, :update]
  end

  get '/postoffice/:country_id/letters' => 'postoffice/letters#index'
  get '/postoffice/:country_id/letters/:id' => 'postoffice/letters#show'
  post '/postoffice/:country_id/letters/:id' => 'postoffice/letters#update'

  post '/login' => 'sessions#create'
end
