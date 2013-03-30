class AddIsActiveToUsers < ActiveRecord::Migration
  def up
    add_column :users, :is_active, :boolean
  end
  def down
  	remove_column :users, :is_active, :boolean
  end
end
