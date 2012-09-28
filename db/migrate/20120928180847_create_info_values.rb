class CreateInfoValues < ActiveRecord::Migration
  def change
    create_table :info_values do |t|
      t.references :info_field_id
      t.integer :associated_object_id
      t.string :associated_object_type
      t.text :content

      t.timestamps
    end
    add_index :info_values, :info_field_id_id
  end
end
