class CreateInfoValues < ActiveRecord::Migration
  def change
    create_table :info_values do |t|
      t.references :info_field
      t.integer :associated_object_id
      t.text :content

      t.timestamps
    end
    add_index :info_values, :info_field_id
  end
end
