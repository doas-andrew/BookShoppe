Rails.application.routes.draw do
  resources :authors
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "sessions#index"

  resources :user_books
  resources :trade_books
  resources :trades
  resources :books
  resources :users
                                                              
  get '/login' => 'sessions#new', as: 'login'
  post '/login' => 'sessions#create' 
  delete '/logout' => 'sessions#destroy', as: 'logout'

  get '/users/:id/trades' => 'users#show_trades', as: 'user_trades'
  get '/users/:id/password' => 'users#edit_password', as: 'edit_password'
  patch '/users/:id/password' => 'users#update_password'
  
  get '/trades/:id/accept' => 'trades#accept', as: 'accept_trade'
  get '/trades/:id/decline' => 'trades#decline', as: 'decline_trade'
end
