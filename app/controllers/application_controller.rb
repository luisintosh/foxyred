class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_params, if: :devise_controller?
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
end
