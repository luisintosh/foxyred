class User < ApplicationRecord
  # Active Record Enum for roles
  # http://api.rubyonrails.org/classes/ActiveRecord/Enum.html
  enum role: [:user, :admin]
  after_initialize :set_default_role, :if => :new_record?
  after_initialize :set_referral_code, :if => :new_record?

  validates :first_name, :last_name, :address, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  protected

  def set_default_role
    # If user doesn't have role, adds one
    self.role ||= :user
  end

  def set_referral_code
    # This creates a new code with letters and numbers until doesn't find it in the db
    begin
      code = (0..5).map { rand(36).to_s(36) }.join
    end while User.exists?(referral_code: code)

    self.referral_code ||= code
  end
end
