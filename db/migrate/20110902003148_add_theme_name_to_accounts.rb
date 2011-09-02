class AddThemeNameToAccounts < ActiveRecord::Migration
  def self.up
    add_column :accounts, :theme_name, :string
  end

  def self.down
    remove_column :accounts, :theme_name, :string
  end
end
