Rails.application.routes.draw do
  devise_for :users
  resources :accounts
  root 'accounts#index'

end