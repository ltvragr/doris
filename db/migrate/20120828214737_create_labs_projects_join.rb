class CreateLabsProjectsJoin < ActiveRecord::Migration
  def up
    create_table :labs_projects, :id => false do |t|
      t.integer "lab_id"
      t.integer "project_id"
    end
    add_index :labs_projects, ["lab_id", "project_id"]
  end

  def down
    drop_table :labs_projects
  end
end
