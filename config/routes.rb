Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "sessions#index"

  resources :books, only: [:index, :new, :create]
  resources :comments, only: [:create, :destroy]

  # Users
  resources :users, except: [:index]
  get '/users/:id/trades' => 'users#show_trades', as: 'user_trades'

  # Trades
  resources :trades
  patch '/trades/:id/accept' => 'trades#accept', as: 'accept_trade'
  patch '/trades/:id/complete' => 'trades#complete', as: 'complete_trade'
  # Used for testing. This path is not intended for users
  # get '/trades/:id/undo' => 'trades#undo'

  # Sessions
  get '/login' => 'sessions#new', as: 'login'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy', as: 'logout'

  get '*path' => 'sessions#index'
end
