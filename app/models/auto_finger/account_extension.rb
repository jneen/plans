class AutoFinger
  module AccountExtension
    extend ActiveSupport::Concern

    included do
      has_many :auto_finger_relations, :class_name => 'AutoFinger'
      has_many :auto_fingers,
        :through => :auto_finger_relations,
        :class_name => 'Account',
        :source => :fingered
    end

    def fingers
      auto_fingers
        .joins(:plan)
        .where { plans.updated_at > auto_fingers.viewed_at }
    end

    def fingering_for(other)
      auto_finger_relations.where { |rel| rel.fingered_id == other.id }.first
    end

    def finger(other)
      auto_fingers << other
    end

    def finger!(other)
      finger(other)
      save
    end

    def ping(other)
      return if guest?
      fingering = fingering_for(other)
      return unless fingering.present?

      fingering.update_attributes viewed_at: Time.now
    end
  end
end
