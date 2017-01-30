class DashboardController < ApplicationController
  def index
    @views = Link.where(user_id: current_user.id).sum(:hits)
    @link_earnings = current_user.withdrawals.sum(:publisher_earnings) + current_user.balance.publisher_earnings
    @ref_earnings = current_user.withdrawals.sum(:referral_earnings) + current_user.balance.referral_earnings
    @av_earnings = current_user.balance.publisher_earnings + current_user.balance.referral_earnings

    sort = params[:sort] || :id
    order = params[:order] || :desc
    limit = params[:limit].to_i || 10
    limit = (limit <= 100) ? limit : 10
    @links = current_user.links.all
                  .search(params[:search])
                  .order(sort => order)
                  .offset(params[:offset])
                  .limit(limit)
  end

  def chart_data 
    dataset = { Views: current_user.links_statistics }
    render json: dataset
  end
end
