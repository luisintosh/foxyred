class DashboardController < ApplicationController
  def index
    @views = Link.where(user_id: current_user.id).sum(:hits)
    @earnings = (current_user.balance.publisher_earnings + current_user.balance.referral_earnings)
    @earnings_collected = (current_user.withdrawals.sum(:amount))
  end

  def chart_data 
    dataset = { Views: current_user.links_statistics }
    render json: dataset
  end
end
