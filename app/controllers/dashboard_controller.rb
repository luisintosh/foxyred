class DashboardController < ApplicationController
  def index
    @chart_data = current_user.links_statistics
  end

  def chart_data 
    dataset = { Views: current_user.links_statistics }
    render json: dataset
  end
end
