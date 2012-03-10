require 'spec_helper'

describe AutoFinger do
  let(:crowd) {
    (1..10).map { build Account }
  }
end
