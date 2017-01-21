class ReferralsController < ApplicationController
  def index
    @referrals = User.where(referred_by: current_user.id)
    @currency_code = Option.get(:currency_code)
    @currency_symbol = Option.get(:currency_symbol)
  end
end
