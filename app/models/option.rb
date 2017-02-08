class Option < ApplicationRecord

    def self.get (name)
        o = Option.find_by(name: name)
        return unless o # Return if option is null

        if o.datatype == 'integer'
            o = o.value.to_i
        elsif o.datatype == 'boolean'
            o = o.value.downcase == 'true'
        else
            o = o.value
        end
    end
end
