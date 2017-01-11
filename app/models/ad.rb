class Ad < ApplicationRecord
    validates :position, :network, :code, :type, :price, :traffic_source, :countries, :start_date, :end_date, :weight, presence: true

    
    def self.get_positions
        [:step1_float_left,
        :step1_float_right,
        :step1_banner_center,
        :step2_frame_url,
        :step2_float_bottom,
        :step3_float_left,
        :step3_float_right,
        :step3_banner_center]
    end
end
