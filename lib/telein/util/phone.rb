module Telein
  module Util
    class Phone

      attr_reader :value, :matching

      FORMAT = /\A\(?(?<area_code>[1-9][0-9])\)?\s*(?<number>(?<extra_digit>9?)[2-9]\d{3}\-?\d{4})\Z/

      def initialize(value)
        if value && (@matching = value.match(FORMAT))
          @value = value
        end
      end

      def to_telein_s
        return nil.to_s unless self.valid?

        [self.area_code,self.number].join
      end

      def area_code
        self.matching[:area_code] if self.matching
      end

      def number
        self.matching[:number].delete('-') if self.matching
      end

      def has_extra_digit?
        return false unless self.matching
        self.matching[:extra_digit] == '9' ? true : false
      end

      def valid?
        if self.area_code && self.number
          if self.has_extra_digit? && self.area_code != '11'
            false
          else
            true
          end
        else
          false
        end
      end

    end
  end
end
