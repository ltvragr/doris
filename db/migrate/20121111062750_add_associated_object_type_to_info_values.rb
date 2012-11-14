class AddAssociatedObjectTypeToInfoValues < ActiveRecord::Migration
  def change
    add_column :info_values, :associated_object_type, :string
  end
end
