class AddTemporaryPasswordToAccounts < ActiveRecord::Migration
  def self.up
    add_column :accounts, :temporary_password, :boolean, :default => false
  end

  def self.down
    remove_column :accounts, :temporary_password
  end
end
