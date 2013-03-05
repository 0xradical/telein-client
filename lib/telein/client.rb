# encoding: utf-8
require 'curb'

module Telein
  class Client

    def carrier_code_for(value)
      return 999 unless Telein.api_key

      phone = Telein::Util::Phone.new(value)

      if phone.valid?
        Telein.servers.each do |server|
          begin
            curl = Curl::Easy.new do |easy|
              easy.url = server.query_url_for(phone.to_telein_s)
            end

            # request no telein
            curl.http_get

            # response do telein
            response = curl.body_str

            # parsing do response (carrier#number)
            carrier_code, _ = response.split('#')

            return carrier_code.to_i
          rescue
            next
          end
        end

        return 101 # nenhum servidor responde
      else
        return 100 #número inválido
      end
    end

  end
end