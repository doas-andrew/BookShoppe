Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :authors
  root "sessions#index"

  resources :books, only: [:index, :new, :create]
  
  resources :comments, only: :create

  resources :users, except: [:index]
  get '/users/:id/trades' => 'users#show_trades', as: 'user_trades'
  
<<<<<<< HEAD
  resources :trades do
    resources :comments, only: [:index, :create, :destroy]
  end

  get '/trades/:id/accept' => 'trades#accept', as: 'accept_trade'
  get '/trades/:id/decline' => 'trades#decline', as: 'decline_trade'
=======
  resources :trades
  patch '/trades/:id/accept' => 'trades#accept', as: 'accept_trade'
  patch '/trades/:id/complete' => 'trades#complete', as: 'complete_trade'
  get '/trades/:id/undo' => 'trades#undo'
>>>>>>> 2c50521c71226f4972ed4f77d746c5bfb5d851a5

  get '/login' => 'sessions#new', as: 'login'
  post '/login' => 'sessions#create' 
  delete '/logout' => 'sessions#destroy', as: 'logout'

  get '*path' => 'sessions#index'


end
