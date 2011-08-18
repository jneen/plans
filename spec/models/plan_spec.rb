require 'spec_helper'

describe Plan do
  let(:plan) { build Plan }

  it 'builds' do
    plan.should be_a Plan
    plan.errors.should == {}
  end
end
