# Namespace for classes and modules that handle the Telein API
module Telein
  extend self

  # Gets/sets api key to access Telein API
  # @return [String]
  attr_accessor :api_key

  # An array of servers available to be requested
  # by the client. The client will use the response
  # of the first one that responds the request.
  # @see Telein::Client#carrier_code_for
  #
  # @return [Array<Telein::Server>]
  def servers
    @servers ||= []
  end

  # Syntax sugar for the {Array#<<} method.
  #
  # @return [Array<Telein::Server>]
  def register_server(server)
    self.servers << server
  end
end

require 'telein/version'
require 'telein/carrier_codes'
require 'telein/util/phone'
require 'telein/server'
require 'telein/client'

# @see Telein::Server#initialize
Telein.register_server(Telein::Server.new('consultanumero1.telein.com.br'))
Telein.register_server(Telein::Server.new('consultanumero2.telein.com.br'))
Telein.register_server(Telein::Server.new('consultanumero3.telein.com.br'))
