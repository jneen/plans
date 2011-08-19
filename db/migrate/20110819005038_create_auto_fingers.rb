class CreateAutoFingers < ActiveRecord::Migration
  def self.up
    create_table :auto_fingers do |t|
      t.belongs_to :account
      t.integer :fingered_id

      t.datetime :viewed_at

      t.timestamps
    end

    add_index :auto_fingers, [:account_id, :fingered_id], unique: true
  end

  def self.down
    drop_table :auto_fingers
  end
end
