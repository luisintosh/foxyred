class HomeController < ApplicationController
  before_action :set_link, only: [:adlink_in,:adlink_out]
  skip_before_action :authenticate_user!
  layout :resolve_layout

  def index
  end

  def adlink_in
    @alias = params[:alias]
  end

  def adlink_out
    @alias = params[:alias]
    if !verify_recaptcha
      redirect_to "/#{@alias}"
    end
  end

  private

  def set_link
    @link = Link.find_by! alias: params[:alias]
  end

  def resolve_layout
    case action_name
    when 'index'
      'home_layout'
    when 'adlink_in', 'adlink_out'
      'adlink_layout'
    else
      'application'
    end
  end
end
