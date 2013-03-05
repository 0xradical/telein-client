module Telein
  extend self

  attr_accessor :api_key

  def servers
    @servers ||= []
  end

  def register_server(server)
    self.servers << server
  end
end

require 'telein/version'
require 'telein/carrier_codes'
require 'telein/util/phone'
require 'telein/server'
require 'telein/client'

Telein.register_server(Telein::Server.new('consultanumero1.telein.com.br'))
Telein.register_server(Telein::Server.new('consultanumero2.telein.com.br'))
Telein.register_server(Telein::Server.new('consultanumero3.telein.com.br'))
