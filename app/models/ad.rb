class Ad < ApplicationRecord
    validates :position, :network, :code, :type, :price, :traffic_source, :countries, :start_date, :end_date, :weight, presence: true

    def self.get_positions
        [:visitin_ad1,
        :visitin_ad2,
        :visitin_ad3,
        :visitin_ad4,
        :visitin_ad5,
        :visitout_ad1,
        :visitout_ad2,
        :visitout_ad3,
        :visitout_ad4,
        :visitout_ad5]
    end
end
