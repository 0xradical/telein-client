# encoding: utf-8
require 'curb'

module Telein
  class Client

    def carrier_code_for(phone)
      return 999 unless Telein.api_key

      if phone && (matching = phone.match(Telein::Util::BRAZILIAN_PHONE_FORMAT))

        # apenas celulares de são paulo tem o 9 extra
        if matching[:code] != '11' && (not matching[:sp_cell_phone_prefix].empty?)
          return 100
        end

        formatted_phone = "#{matching[:code]}#{matching[:number].delete('-')}"

        Telein.servers.each do |server|
          begin
            curl = Curl::Easy.new do |easy|
              easy.url = server.query_url_for(formatted_phone)
            end

            # request no telein
            curl.http_get

            # response do telein
            response = curl.body_str

            # parsing do response (carrier#number)
            carrier_code, phone_number = response.split('#')

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