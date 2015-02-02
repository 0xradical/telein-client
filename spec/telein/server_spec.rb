require 'spec_helper'
require 'uri'

describe Telein::Server do

  it 'returns query url for a given phone' do
    Telein.api_key = 'my_api_key'
    endpoint       = 'consultaoperadora1.telein.com.br'
    phone          = '1234345656'

    server = described_class.new(endpoint)

    server.query_url_for(phone).should == 'http://consultaoperadora1.telein.com.br/sistema/consulta_resumida.php?numero=1234345656&chave=my_api_key'
  end

end