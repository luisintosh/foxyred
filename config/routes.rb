Rails.application.routes.draw do

  resources :ads
  resources :links
  resources :pages
  resources :payout_rates
  resources :options
  devise_for :users
  root 'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
