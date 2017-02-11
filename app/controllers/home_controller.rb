class HomeController < ApplicationController
  skip_before_action :authenticate_user!
  layout 'home_layout'

  def index
    @csymbol = Option.get :currency_symbol
    @ccode = Option.get :currency_code
    @min_pr = PayoutRate.where(country_code: :xx).last.earn.to_s
  end

  def rates
    @rates = PayoutRate.all
    @csymbol = Option.get :currency_symbol
    @ccode = Option.get :currency_code
    @min_pr = PayoutRate.where(country_code: :xx).last.earn.to_s
  end

  def terms
  end
end
