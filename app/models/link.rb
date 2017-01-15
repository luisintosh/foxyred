class Link < ApplicationRecord
  belongs_to :user
  after_initialize :configure_link, :if => :new_record?
  enum status: [:active, :suspended]

  validates :user_id, :url, presence: true
  # regex valid urls without ip addresses
  validates :url, format: { with: %r{\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?}i, message: 'Only allow valid urls' }
  # validate url not in disallowed_domains array
  validate :exclude_urls

  def self.search(search)
    if search
      where('url LIKE ?', "%#{search}%")
    else
      self
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
