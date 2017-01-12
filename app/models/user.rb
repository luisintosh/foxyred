class User < ApplicationRecord
  # Active Record Enum for roles
  # http://api.rubyonrails.org/classes/ActiveRecord/Enum.html
  enum role: [:user, :admin]
  before_save :configure_user, :if => :new_record?
  after_save :create_balance, :if => :new_record?

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
      code = :random_code
      loop do
        code = SecureRandom.base58 5
        break unless User.exists?(referral_code: code)
      end

      self.referral_code ||= code
    end

    def create_balance
      # Create its account balance
      self.create_balance(publisher_earnings: 0.0, referral_earnings: 0.0)
    end
end
