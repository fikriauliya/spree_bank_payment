class AddAccountNameToBank < ActiveRecord::Migration
  def change
    add_column :spree_banks, :account_name, :string
  end
end
