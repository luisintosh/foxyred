class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_params, if: :devise_controller?
  before_action :configure_referral_cookie, if: :devise_controller? || :home_controller?
  layout :layout_by_resource # set devise user layout for unsigned users

  protected

  def configure_permitted_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:referred_by,:first_name,:last_name,:address])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name,:last_name,:address,:tel,:withdrawal_method,:withdrawal_account])
  end

  def layout_by_resource
    if devise_controller? && !user_signed_in?
      'devise_layout'
    else
      'application'
    end
  end

  def configure_referral_cookie
    if params[:r]
      cookies.signed[:r] = { value: params[:r], expires: 1.day.from_now }
    end
  end

  # Devise methods

  def after_sign_in_path_for(resource)
    dashboard_path
  end

  def after_sign_up_path_for(resource)
    dashboard_path
  end

  def after_update_path_for(resource)
    dashboard_path
  end
end
