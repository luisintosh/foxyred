class Ad < ApplicationRecord
    validates :position, :network, :code, presence: true

    def self.get_positions
        pos = [
            'step1_banner_300x250',
            'step1_banner_160x600',
            'step1_banner_300x100',
            'step1_popup',
            'step1_mobile',
            'step2_banner_300x250',
            'step2_banner_160x600',
            'step2_banner_300x100',
            'step2_popup',
            'step2_mobile'
        ]
        pos.collect { |p| [p.humanize, p] }
    end

    def self.get_sources
        scs = [
            'mobile',
            'desktop'
        ]
        scs.collect { |s| [s.humanize, s] }
    end

    def self.get(pos)
        ad = Ad.where(position: pos).sample
        if ad && Option.get(:enable_ads)
            ad.update weight: ad.weight.to_i + 1 
            ad.code.html_safe
        end
    end
end
