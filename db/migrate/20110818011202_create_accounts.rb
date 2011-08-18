class CreateAccounts < ActiveRecord::Migration
  def self.up
    create_table :accounts do |t|
      t.string :login, null: false
      t.string :salt, null: false
      t.string :crypted_password, null: false
      t.timestamps
    end

    add_index :accounts, :login, unique: true
  end

  def self.down
    drop_table :accounts
  end
end
