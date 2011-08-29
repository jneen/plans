require 'spec_helper'

describe Planlove do
  let(:man) { build Account }
  let(:other_man) { build Account }
  let(:plan) { other_man.plan }

  before do
    Account.destroy_all
    Plan.destroy_all
    man.save!
    other_man.save!
  end

  it 'calculates planlove on validating a plan' do
    plan.planloves.should == []
    plan.contents = "yo, @#{man.login}"

    plan.save!

    plan.planloves.map(&:account).should == [man]
  end

  after do
  end
end
