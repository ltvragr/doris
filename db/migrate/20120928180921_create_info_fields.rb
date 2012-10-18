class CreateInfoFields < ActiveRecord::Migration
  def change
    create_table :info_fields do |t|
      t.string :associated_object
      t.string :associated_role
      t.string :label
      t.string :content_type
      t.text :content
      t.integer :sort_order
      t.string :category

      t.timestamps
    end
  end
end
