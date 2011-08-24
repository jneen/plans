class Planlove
  module AccountExtension
    extend ActiveSupport::Concern

    included do
      has_many :planloves
      has_many :planlovers,
        :source => :plan,
        :through => :planloves,
        :class_name => 'Plan'
    end

    def recent_lovers
      planlovers.includes(:account).order { updated_at.desc }
    end
  end
end
