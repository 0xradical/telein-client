require 'uri'

module Telein
  class Server
    attr_accessor :endpoint

    def initialize(endpoint)
      self.endpoint = endpoint
    end

    def query_url_for(phone)
      url = URI::HTTP.build({:host  => self.endpoint,
                             :path  => '/sistema/consulta_numero.php',
                             :query => URI::encode_www_form({:numero => phone,:chave => Telein.api_key})})
      url.to_s
    end
  end
end