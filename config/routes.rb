Rails.application.routes.draw do
  resources :users, only: [:create, :show] do
    resources :owls, only: [:index]
    resources :letters, only: [:index, :create, :show, :update]
  end

  # If we want to display all letters with countries, where the user can pick a country
  # get '/postoffice/:country_id/letters' => 'postoffice/letters#index'
  # put '/postoffice/:country_id/letters/:id' => 'postoffice/letters#update'
  # patch '/postoffice/:country_id/letters/:id' => 'postoffice/letters#update'

  put '/postoffice/:country_id/new' => 'postoffice/letters#update'
  patch '/postoffice/:country_id/new' => 'postoffice/letters#update'

  post '/login' => 'sessions#create'

  get '/ip_country' => 'sessions#index'
end
