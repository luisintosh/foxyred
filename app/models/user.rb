class User < ApplicationRecord
  # Active Record Enum for roles
  # http://api.rubyonrails.org/classes/ActiveRecord/Enum.html
  enum role: [:user, :admin]
  after_save :configure_user, :if => :new_record?

  validates :first_name, :last_name, :address, presence: true

  has_many :withdrawals, dependent: :destroy
  has_many :links, dependent: :destroy
  has_one  :balance, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  protected

  def configure_user
    # If user doesn't have role, adds one
    self.role ||= :user

    # This creates a new code with letters and numbers until doesn't find it in the db
    begin
      code = (0..5).map { rand(36).to_s(36) }.join
    end while User.exists?(referral_code: code)

    self.referral_code ||= code

    # Create its account balance
    self.create_balance(publisher_earnings: 0.0, referral_earnings: 0.0)
  end
end
