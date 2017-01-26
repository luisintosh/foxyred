class Withdrawal < ApplicationRecord
  enum status: [:successful, :pending]
  belongs_to :user
end
