class WithdrawController < ApplicationController
  def index
    @withdrawals = current_user.withdrawals
  end
end
