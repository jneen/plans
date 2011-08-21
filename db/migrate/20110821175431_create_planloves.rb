class CreatePlanloves < ActiveRecord::Migration
  def self.up
    create_table :planloves do |t|
      t.belongs_to :plan
      t.belongs_to :account
      t.integer    :count

      t.timestamps
    end

    add_index :planloves, :account_id
    add_index :planloves, [:plan_id, :account_id], unique: true
  end

  def self.down
    drop_table :planloves
  end
end
