class AddIsConfirmedToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :is_confirmed, :boolean
  	Project.update_all ["is_confirmed = ?", true]
  end
end
