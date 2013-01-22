class AddIsAuthorizedToLabs < ActiveRecord::Migration
  def self.up
    add_column :labs, :is_authorized, :boolean
  end

  def self.down
  	remove_column :labs, :is_authorized, :boolean
  end
end
