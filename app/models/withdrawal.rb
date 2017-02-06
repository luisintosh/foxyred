class Withdrawal < ApplicationRecord
  enum status: [:pending, :approved, :paid, :canceled]
  belongs_to :user

  def self.wd_methods
    methods = []
    
    methods.push 'paypal' if Option.get(:enable_paypal)
    methods.push 'payza' if Option.get(:enable_payza)
    methods.push 'payoneer' if Option.get(:enable_payoneer)
    methods.push 'bitcoin' if Option.get(:enable_bitcoin)
    methods.push 'webmoney' if Option.get(:enable_webmoney)
    methods.push 'skrill' if Option.get(:enable_skrill)

    methods
  end

  def self.has_available_wd_method? (user)
    available = Withdrawal.wd_methods.include? user.withdrawal_method
    
    # remove invalid wd
    unless available
      user.withdrawal_method = nil
      user.withdrawal_account = nil
      user.save
    end
    
    available
  end

  def self.next_pay_day
    #days = Option.get('paydays')
    #days = days.split(',').map { |i| i.to_i }
    #payday = nil
    month15 = Time.new Time.now.year, Time.now.month, 15
    
    if Time.now < month15
      month15
    else
      month15 + 1.month - 14.days
    end
  end
end
