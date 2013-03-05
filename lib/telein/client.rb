# encoding: utf-8
require 'curb'

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

    # Queries the Telein servers for the carrier code of value
    #
    # @param value [String] A string supposedly containing phone information
    # @return [Integer] The carrier code for value
    def carrier_code_for(value)
      return 999 unless Telein.api_key

      phone = Telein::Util::Phone.new(value)

      if phone.valid?
        Telein.servers.each do |server|
          begin
            curl = Curl::Easy.new do |easy|
              easy.url = server.query_url_for(phone.to_telein_s)
            end

            # client request
            curl.http_get

            # telein response
            response = curl.body_str

            # response parsing (carrier#number)
            carrier_code, _ = response.split('#')

            return carrier_code.to_i
          rescue
            next
          end
        end

        # all servers down
        return 101
      else
        # invalid phone
        return 100
      end
    end

  end
end