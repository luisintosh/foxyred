Rails.application.routes.draw do

  # user panel
  scope '/panel' do
    resources :ads, :links, :pages, :payout_rates, :options, :users
    get 'dashboard', to: 'dashboard#index', as: :dashboard
    get 'dashboard/chart_data', to: 'dashboard#chart_data'
    get 'referrals', to: 'referrals#index', as: :referrals
    get 'withdraw', to: 'withdraw#index', as: :withdraw
    get 'tools', to: 'tools#index', as: :tools
    post 'tools', to: 'tools#index'
    get 'payments', to: 'payments#index'
    as :user do
      get 'user/profile', :to => 'devise/registrations#edit', :as => :user_root
    end
  end

  # user administration
  devise_for :users, path: 'auth', path_names: { sign_in: 'login', sign_up: 'sign_up', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'register' }, controllers: { registrations: 'registrations' }
  devise_scope :user do
    get '/signout', to: 'devise/sessions#destroy', as: :signout
  end

  # root
  root 'home#index'
  get '/rates', to: 'home#rates', as: :rates
  get '/terms', to: 'home#terms', as: :terms

  # link api
  get 's/:referral_code', to: 'links#quick_link'
  get 'api/:referral_code', to: 'links#api_link'

  #show ad link
  get '/:alias', to: 'links#visit_step1', constraints: { alias: /\w+/ }
  get 'go/:alias', to: 'links#visit_step2', constraints: { alias: /\w+/ }
  post 'go/:alias', to: 'links#visit_step2', constraints: { alias: /\w+/ }


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
