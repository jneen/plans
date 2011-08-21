class Planlove
  module AccountExtension
    extend ActiveSupport::Concern

    included do
      has_many :planloves
      has_many :planlovers,
        :source => :account,
        :through => :planloves,
        :class_name => 'Plan'
    end
  end
end
