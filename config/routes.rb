Rails.application.routes.draw do
  resources :users, only: [:create, :show] do
    resources :owls, only: [:index]
    resources :letters, only: [:index, :create, :show]
  end

  get '/postoffice/:country_id/letters' => 'letters#index'
  get '/postoffice/:country_id/letters/:id' => 'letters#show'
  post '/postoffice/:country_id/letters/:id' => 'letters#update'

  post '/login' => 'sessions#create'
end
