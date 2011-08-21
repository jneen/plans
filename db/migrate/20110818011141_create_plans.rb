class CreatePlans < ActiveRecord::Migration
  def self.up
    create_table :plans do |t|
      t.text :contents, null: false, default: ''
      t.text :html, null: false

      t.belongs_to :account, null: false

      t.timestamps
    end

    add_index :plans, :account_id, unique: true
  end

  def self.down
    drop_table :plans
  end
end
