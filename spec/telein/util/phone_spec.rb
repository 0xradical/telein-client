require 'spec_helper'

describe Telein::Util::Phone do

  it 'rejects invalid phones' do
    phone = described_class.new('anything')
    phone.number.should be_nil
    phone.area_code.should be_nil
    expect(phone.has_extra_digit?).to be_false
    expect(phone.valid?).to be_false

    phone = described_class.new('(12) 3434-5656')
    phone.number.should == '34345656'
    phone.area_code.should == '12'
    expect(phone.has_extra_digit?).to be_false
    expect(phone.valid?).to be_true

    phone = described_class.new('(21) 9434-5656')
    phone.number.should == '94345656'
    phone.area_code.should == '21'
    expect(phone.has_extra_digit?).to be_false
    expect(phone.valid?).to be_true

    phone = described_class.new('(21) 99434-5656')
    phone.number.should == '994345656'
    phone.area_code.should == '21'
    expect(phone.has_extra_digit?).to be_true
    expect(phone.valid?).to be_false
  end

  it 'returns format for telein purposes' do
    phone = described_class.new('(21) 9434-5656')
    phone.to_telein_s.should == '2194345656'

    phone = described_class.new('2194345656')
    phone.to_telein_s.should == '2194345656'
  end

end