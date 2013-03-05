module Telein
  # Utility classes
  module Util
    # Class that encapsulates phone data logic
    class Phone

      # The Matching parts of Phone::FORMAT
      #
      # @return [MatchData] A +MatchData+ object containing the matching made against value
      # @see #initialize
      attr_reader :matching

      # General format of a Brazilian phone.
      # An area_code and a number that may contain and extra 9
      FORMAT = /\A\(?(?<area_code>[1-9][0-9])\)?\s*(?<number>(?<extra_digit>9?)[2-9]\d{3}\-?\d{4})\Z/

      # @param value [String] a string containing phone information
      def initialize(value)
        @matching = value.match(FORMAT) if value
      end

      # Returns a string ready to be consumed by Telein API
      # @example Return a formatted phone
      #   phone = Telein::Util::Phone.new('(12) 3434-5656')
      #   phone.to_telein_s # => '1234345656'
      #
      # @return [String] a string in Telein format
      def to_telein_s
        return nil.to_s unless self.valid?

        [self.area_code,self.number].join
      end

      # Returns the area code for phone
      #
      # @return [String] the area code of phone
      def area_code
        self.matching[:area_code] if self.matching
      end

      # Returns the number part of phone (everything minus area code)
      #
      # @return [String] the number part of phone
      def number
        self.matching[:number].delete('-') if self.matching
      end

      # Checks if phone has an extra digit
      # The extra digit '9' was introduced only to phones
      # in 11 area code (São Paulo) to account for new phones
      #
      # @return [Boolean] whether phone has an extra 9
      def has_extra_digit?
        return false unless self.matching
        self.matching[:extra_digit] == '9' ? true : false
      end

      # Checks if phone is valid
      # This is a loosen check, in the sense that it accepts
      # a wide range of probably invalid phones, like
      # (99) 9999-9999 but the specs for area codes in Brazil
      # are also loosen, allowing the existence of such numbers in the future.
      # Also, for phones in the 11 area, the method may return false
      # positives, since only cellphones have that extra digit.
      #
      # @return [Boolean] whether phone is valid or invalid
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
