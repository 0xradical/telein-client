# encoding: utf-8
require 'net/http'

module Telein
  # Class used to query Telein servers for carrier codes
  #
  # No API key given
  # ----------------
  # The client doesn't make any request if the {Telein#api_key API key}
  # is missing, returning a 999 code immediately.
  #
  # Invalid phones
  # --------------
  # Telein can tell if a given phone is invalid but each
  # request is a credit spent so the class also encapsulates
  # the code from Telein::Util::Phone to detect invalid ones
  # preemptively.
  #
  # All servers down
  # ----------------
  # If all {Telein#register_server Registered servers} are
  # down, then the client return 101 for carrier_code
  #
  # @example Query servers for the carrier code of a given phone
  #    client = Telein::Client.new
  #    client.carrier_code_for('(12) 3434-5656') # => '41'
  class Client

    # Queries the Telein servers for the carrier code and corrected
    #   phone number of value.
    # @param value [String] A string supposedly containing phone information
    # @return [Array<Integer, String>] A pair with carrier code for value
    #    and corrected phone number.
    private
    def raw_query(value)
      phone = Telein::Util::Phone.new(value)

      return [999, value] unless Telein.api_key

      if phone.valid?
        Telein.servers.each do |server|
          begin
            response = Net::HTTP.get URI(server.query_url_for(phone.to_telein_s))

            # response parsing (carrier#number)
            carrier_code, number = response.split('#')

            return [101, number] if carrier_code.to_i == 0

            return [carrier_code.to_i, number]
          rescue
            next
          end
        end

        # all servers down
        return [101, phone.to_telein_s]
      else
        # invalid phone
        return [100, value]
      end
    end
    # Wraps the query to the Telein servers for the carrier code and
    #   corrected phone number of value on a dictionary.
    # @param value [String] A string supposedly containing phone information
    # @return [Hash] with :carrier_code as the carrier code
    #    and :number as the corrected phone number.
    public
    def query(value)
      carrier_code, number = raw_query(value)
      return { :carrier_code => carrier_code, :number => number }
    end

    # Filters the query to the Telein servers so that it only returns
    #   the carrier code.
    # @deprecated Use {#query} for greater functionality.
    # @param value [String] A string supposedly containing phone information
    # @return [Integer] The carrier code for value
    def carrier_code_for(value)
      return query(value)[:carrier_code]
    end
  end
end
