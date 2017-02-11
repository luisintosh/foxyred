class User < ApplicationRecord
  # Active Record Enum for roles
  # http://api.rubyonrails.org/classes/ActiveRecord/Enum.html
  enum role: [:user, :admin, :disabled]
  after_initialize :create_balance, :if => :new_record?
  before_save :configure_user, :if => :new_record?

  validates :first_name, :last_name, :address, presence: true

  has_many :withdrawals, dependent: :destroy
  has_many :links, dependent: :destroy
  has_one  :balance, dependent: :destroy, autosave: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable


  def links_statistics
    mdays = Time.days_in_month(Time.now.month, Time.now.year)
    dataset = [0]
    1.upto(mdays) do |day|
      dataset.push Statistic.joins(:link)
                            .where('links.user_id': self.id, 
                                    'statistics.created_at': Time.parse("#{Time.now.year}-#{Time.now.month}-#{day}").utc.all_day).count
    end
    dataset
  end

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
      self.build_balance
    end
end
