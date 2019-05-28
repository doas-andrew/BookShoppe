Rails.application.routes.draw do

  resources :user_books
  resources :trade_books
  resources :trades
  resources :books
  resources :users

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  get '/users/:id/trades' => 'users#show_trades', as: 'user_trades'
  

  root "users#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/trades/:id/accept' => 'trades#accept', as: 'accept_trade'
  get '/trades/:id/decline' => 'trades#decline', as: 'decline_trade'
end
