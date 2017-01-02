class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_params, if: :devise_controller?

  protected

  def configure_permitted_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:referred_by,:first_name,:last_name,:address])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name,:last_name,:address,:tel,:withdrawal_method,:withdrawal_account])
  end
end
