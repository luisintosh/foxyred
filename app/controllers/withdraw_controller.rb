class WithdrawController < ApplicationController
  def index
    @withdrawals = current_user.withdrawals
    @total_earnings = current_user.withdrawals.where(status: :paid).last
    @total_earnings = @total_earnings.amount if @total_earnings
    @total_earnings ||= 0.0
    @next_payment = current_user.withdrawals.where(status: :pending).sum(:amount)
  end
end
