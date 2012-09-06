class CreateLabs < ActiveRecord::Migration
  def change
    create_table :labs do |t|
      t.string :name
      t.string :url
      t.text :description

      t.timestamps
    end
  end
end
