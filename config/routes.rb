Rails.application.routes.draw do

  # user panel
  resources :ads, :links, :pages, :payout_rates, :options
  get 'dashboard', to: 'dashboard#index', as: 'dashboard'
  get 'dashboard/chart_data', to: 'dashboard#chart_data'
  get 'referrals', to: 'referrals#index', as: 'referrals'
  get 'withdraw', to: 'withdraw#index', as: 'withdraw'
  get 'tools', to: 'tools#index', as: 'tools'
  post 'tools', to: 'tools#index'
  
  # user administration
  devise_for :users, path: 'auth', path_names: { sign_in: 'login', sign_up: 'sign_up', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'register' }

  # root
  root 'home#index'

  #show ad link
  get '/:alias', to: 'links#visit_in', constraints: { alias: /\w+/ }
  get 'go/:alias', to: 'links#visit_out', constraints: { alias: /\w+/ }
  post 'go/:alias', to: 'links#visit_out', constraints: { alias: /\w+/ }


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
