Rails.application.routes.draw do
  resources :authors
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "sessions#index"

  resources :books, only: [:index, :new, :create]

  resources :users, except: [:index]
  get '/users/:id/trades' => 'users#show_trades', as: 'user_trades'
  
  resources :trades
  get '/trades/:id/accept' => 'trades#accept', as: 'accept_trade'
  get '/trades/:id/decline' => 'trades#decline', as: 'decline_trade'

  get '/login' => 'sessions#new', as: 'login'
  post '/login' => 'sessions#create' 
  delete '/logout' => 'sessions#destroy', as: 'logout'

  get '*path' => 'sessions#index'
end
