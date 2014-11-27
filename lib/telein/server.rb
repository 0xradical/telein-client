require 'uri'

module Telein
  # The class that encapsulates all code that build
  # request queries made to Telein servers by the client
  #
  # @example Instantiate a server and build a query for phone
  #   server = Telein::Server.new('consultanumero1.telein.com.br')
  #   server.query_url_for('1234345656')
  #   => 'http://consultanumero1.telein.com.br/sistema/consulta_numero.php?numero=1234345656&chave=my_api_key'
  class Server
    # Gets/sets the endpoint (an URL) representing
    # a Telein Server
    #
    # @return [String] the endpoint
    attr_accessor :endpoint

    # @param endpoint [String] The URL of the server
    def initialize(endpoint)
      self.endpoint = endpoint
    end

    # Builds a request URL to be used by the client to fetch the carrier code
    #
    # @param phone [String] A phone in the {Telein::Util::Phone#to_telein_s Telein format}
    # @return [String] A URL the client will use to fetch the carrier code
    # @see Telein::Client#carrier_code_for
    def query_url_for(phone)
      url = URI::HTTP.build({:host  => self.endpoint,
                             :path  => '/sistema/consulta_resumida.php',
                             :query => URI::encode_www_form({:numero => phone,:chave => Telein.api_key})})
      url.to_s
    end
  end
end