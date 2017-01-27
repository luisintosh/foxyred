class Withdrawal < ApplicationRecord
  enum status: [:successful, :pending]
  belongs_to :user

  def self.wd_methods
    ['Paypal.com']
  end
end
