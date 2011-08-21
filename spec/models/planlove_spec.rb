require 'spec_helper'

describe Planlove do
  let(:man) { build Account }
  let(:plan) { build Plan }

  before(:each) do
    man.save!
    plan.save!
  end

  it 'calculates planlove on validating a plan' do
    plan.planloves.should == []
    plan.contents = "yo, @#{man.login}"

    plan.save!

    plan.planloves.map(&:account).should == [man]
  end
end
