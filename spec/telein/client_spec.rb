require 'spec_helper'

describe Telein::Client do

  before(:each) do
    Telein.api_key = 'my_api_key'
  end

  after(:each) do
    WebMock.reset!
  end

  it 'returns 999 when no api key is provided' do
    Telein.api_key = nil

    Telein.servers.each do |server|
      stub_request(:get,server.query_url_for('0000000000')).to_return(:body => '99#0000000000')
      stub_request(:get,server.query_url_for('1234345656')).to_return(:body => '98#1234345656')
      stub_request(:get,server.query_url_for('1294345656')).to_return(:body => '41#1294345656')
    end

    client = described_class.new
    client.carrier_code_for('(00) 0000-0000').should == 999
    client.carrier_code_for('(12) 3434-5656').should == 999
    client.carrier_code_for('(12) 9434-5656').should == 999
  end

  it 'returns carrier codes' do
    Telein.servers.each do |server|
      stub_request(:get,server.query_url_for('0000000000')).to_return(:body => '99#0000000000')
      stub_request(:get,server.query_url_for('1234345656')).to_return(:body => '98#1234345656')
      stub_request(:get,server.query_url_for('1294345656')).to_return(:body => '41#1294345656')
    end

    client = described_class.new
    client.carrier_code_for('(00) 0000-0000').should == 100
    client.carrier_code_for('(12) 3434-5656').should == 98
    client.carrier_code_for('(12) 9434-5656').should == 41
  end

  it 'returns both carrier code and fixed number' do
    Telein.servers.each do |server|
      stub_request(:get,server.query_url_for('0000000000')).to_return(:body => '99#0000000000')
      stub_request(:get,server.query_url_for('1234345656')).to_return(:body => '98#1234345656')
      stub_request(:get,server.query_url_for('1294345656')).to_return(:body => '41#12994345656')
    end

    client = described_class.new
    expect(client.query('(00) 0000-0000')).to  eq({ carrier_code: 100, number: "(00) 0000-0000"})
    expect(client.query('(12) 3434-5656')).to  eq({ carrier_code:  98, number: "1234345656"})
    expect(client.query('(12) 9434-5656')).to  eq({ carrier_code:  41, number: "12994345656"})
  end

  it 'returns server error code when all endpoints are down' do
    Telein.servers.each do |server|
      stub_request(:get,server.query_url_for('0000000000')).to_timeout
      stub_request(:get,server.query_url_for('1234345656')).to_timeout
      stub_request(:get,server.query_url_for('1294345656')).to_timeout
    end

    client = described_class.new
    client.carrier_code_for('(00) 0000-0000').should == 100
    client.carrier_code_for('(12) 3434-5656').should == 101
    client.carrier_code_for('(12) 9434-5656').should == 101
  end

  it 'returns server error code when carrier code is not present' do
    Telein.servers.each do |server|
      stub_request(:get,server.query_url_for('0000000000')).to_return(:body => '')
      stub_request(:get,server.query_url_for('1234345656')).to_return(:body => '')
      stub_request(:get,server.query_url_for('1294345656')).to_return(:body => '')
    end

    client = described_class.new
    client.carrier_code_for('(00) 0000-0000').should == 100
    client.carrier_code_for('(12) 3434-5656').should == 101
    client.carrier_code_for('(12) 9434-5656').should == 101
  end
end
