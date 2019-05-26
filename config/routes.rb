Rails.application.routes.draw do
  resources :user_books
  resources :trade_books
  resources :trades
  resources :books
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
