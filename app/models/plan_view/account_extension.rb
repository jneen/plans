class PlanView
  module AccountExtension
    extend ActiveSupport::Concern

    included do
      has_many :plan_view_relations, :class_name => 'PlanView'
      has_many :plan_views,
        :through => :plan_view_relations,
        :class_name => 'Account',
        :source => :viewed
    end

    # This is quadratic in the number of users.
    # Not to mention unwieldy in the UI.
    def updated_plans
      plan_views
        .joins(:plan)
        .where { plans.updated_at > plan_views.viewed_at }
    end

    def plan_view_for(other)
      plan_view_relations
        .where { |rel| rel.viewed_id == other.id }
        .first_or_create
    end

    def view(other)
      return if guest?
      view = plan_view_for(other)
      view.update_attributes viewed_at: Time.now
    end
  end
end
