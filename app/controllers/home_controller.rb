class HomeController < ApplicationController
  skip_before_action :authenticate_user!
  layout 'home_layout'

  def index
    @page_title = Option.get :site_name
    @csymbol = Option.get :currency_symbol
    @ccode = Option.get :currency_code
    @min_pr = PayoutRate.where(country_code: :xx).last.earn.to_s
  end

  def rates
    @page_title = "Payout rates | #{Option.get :site_name}"
    @rates = PayoutRate.all
    @csymbol = Option.get :currency_symbol
    @ccode = Option.get :currency_code
    @min_pr = PayoutRate.where(country_code: :xx).last.earn.to_s
  end

  def terms
  end

  def disable_adblock
    @page_title = "Please disable AdBlock to continue | #{Option.get :site_name}"
  end
end
