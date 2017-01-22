Rails.application.routes.draw do
  # user panel
  resources :ads, :links, :pages, :payout_rates, :options
  get 'referrals', to: 'referrals#index', as: 'referrals'
  
  # user administration
  devise_for :users
  # root
  root 'home#index'

  #show ad link
  get '/:alias', to: 'links#visit_in', constraints: { alias: /\w+/ }, via: :get
  get 'go/:alias', to: 'links#visit_out', constraints: { alias: /\w+/ }, via: :get
  post 'go/:alias', to: 'links#visit_out', constraints: { alias: /\w+/ }, via: :post


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
