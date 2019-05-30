Rails.application.routes.draw do
  resources :authors
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "sessions#index"

  resources :books, only: [:index, :new, :create]
  
  resources :comments, only: [:index, :create, :destroy]

  resources :users, except: [:index]
  get '/users/:id/trades' => 'users#show_trades', as: 'user_trades'
  
  resources :trades
  patch '/trades/:id/accept' => 'trades#accept', as: 'accept_trade'
  patch '/trades/:id/complete' => 'trades#complete', as: 'complete_trade'
  get '/trades/:id/undo' => 'trades#undo'

  get '/login' => 'sessions#new', as: 'login'
  post '/login' => 'sessions#create' 
  delete '/logout' => 'sessions#destroy', as: 'logout'

  get '*path' => 'sessions#index'


end
