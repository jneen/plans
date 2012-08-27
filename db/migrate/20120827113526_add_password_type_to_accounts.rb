class AddPasswordTypeToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :password_type, :string, :default => 'sha2'
    # remove the :null => false constraint
    change_column :accounts, :salt, :string, :null => true
  end
end
