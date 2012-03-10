class ChangeAutoFingersToPlanViews < ActiveRecord::Migration
  def self.up
    rename_table :auto_fingers, :plan_views
    rename_column :plan_views, :fingered_id, :viewed_id
  end

  def self.down
    rename_table :plan_views, :auto_fingers
    rename_column :auto_fingers, :viewed_id, :fingered_id
  end
end
