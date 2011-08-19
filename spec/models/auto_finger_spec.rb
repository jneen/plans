require 'spec_helper'

describe AutoFinger do
  let(:crowd) {
    (1..10).map { build Account }
  }

  let(:fred) {
    build Account, auto_fingers: crowd
  }

  it 'builds with auto_finger_accounts' do
    fred.save!
    Account.find(fred.id).auto_fingers.size.should == 10
  end
end
