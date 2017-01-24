class Link < ApplicationRecord
  belongs_to :user
  has_many :statistics, dependent: :destroy
  after_initialize :configure_link, :if => :new_record?
  enum status: [:active, :suspended]

  validates :user_id, :url, presence: true
  # regex valid urls without ip addresses
  validates :url, format: { with: %r{\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?}i, message: 'Only allow valid urls' }
  # validate url not in disallowed_domains array
  validate :exclude_urls

  # Class method to search
  def self.search(search)
    if search
      where('url LIKE ?', "%#{search}%")
    else
      self
    end
  end

  # Logic to record visits
  def new_visit(visit)
    # Chek ip in db
    last_visit = Statistic.where(ip: visit.ip).last
    # Ends if the last visit has no more than 1 day
    if last_visit && ((last_visit.created_at + 1.day) > Time.now)
      return
    else
      rate = PayoutRate.find_by(country_code: visit.country)
      # If is empty asign default payout rate
      rate ||= PayoutRate.find_by(country_code: :xx)
      # Calculate earning per view
      earnings = rate.earn / 1000
      # Save record
      Statistic.create( 
              link_id: self.id, 
              user_agent: visit.user_agent, 
              ip: visit.ip, 
              country: visit.country, 
              referrer_domain: visit.referring_domain, 
              publisher_earn: earnings)
      # Set new hit to this link
      self.hits = (self.hits).to_i + 1
      self.save
      # Save earnings
      balance = self.user.balance
      balance.publisher_earnings += earnings
      balance.save
      # Send earnings to referral user 
      if self.user.referred_by
        refer = User.find self.user.referred_by
        refer.referral_earnings( earnings*(Option.get(:referral_percentage)/100) )
        refer.save
      end
    end
  end

  protected
    def configure_link
      code = :random_code
      loop do
        code = SecureRandom.base58 Option.get :alias_length
        break unless User.exists?(referral_code: code)
      end

      self.alias ||= code
      self.status ||= :active
    end

    def exclude_urls
      excluded_domains = Option.get(:disallowed_domains)
      excluded_domains = excluded_domains.split(',') if excluded_domains

      excluded_domains.each do |domain|
        if self.url.start_with? domain
          return errors.add :url, 'This is not a valid url'  
        end
      end
    end

end
