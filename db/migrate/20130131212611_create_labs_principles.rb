class CreateLabsPrinciples < ActiveRecord::Migration
  def up
    create_table :labs_principles, :id => false do |t|
      t.integer "lab_id"
      t.integer "user_id"
    end
    add_index :labs_principles, ["lab_id", "user_id"]
    #Lab.update_all["principles = ?", []]
  end

  def down
    drop_table :labs_principles
  end
end
