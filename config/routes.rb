Rails.application.routes.draw do
  resources :users do
    resources :songs, only: [:new, :create, :show]
  end

  get '/signin', to: 'sessions#new'
  post '/signin', to: 'sessions#create'
  delete '/signout', to: 'sessions#destroy'
end
