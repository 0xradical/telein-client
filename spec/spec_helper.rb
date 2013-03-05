$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'telein'
require 'rspec'
require 'webmock'
require 'webmock/rspec'