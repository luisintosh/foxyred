class PaymentsController < ApplicationController
  before_action :admin_only
  
  def index
    @users = User.joins(:withdrawals).where('withdrawals.status': :paid)
    @total_earnings = Withdrawal.where(status: :paid).sum(:amount)
    @next_payment = Withdrawal.where(status: :pending).sum(:amount)
  end

  private
    def admin_only
      unless current_user.admin?
        redirect_to root_path, :alert => "Access denied."
      end
    end
end
