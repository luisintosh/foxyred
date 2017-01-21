Rails.application.routes.draw do
  # user panel
  resources :ads, :links, :pages, :payout_rates, :options
  get 'referrals', to: 'referrals#index', as: 'referrals'
  
  # user administration
  devise_for :users
  # root
  root 'home#index'

  #show ad link
  get '/:alias', to: 'home#adlink_in', constraints: { alias: /\w+/ }, via: :get
  post 'go/:alias', to: 'home#adlink_out', constraints: { alias: /\w+/ }, via: :post


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
