class InfoValue < ActiveRecord::Base
  belongs_to :info_field

  attr_accessible :associated_object_id, :associated_object_type, :content

  def sorted_values_for_object(object)
  	#This needs to be re-written now that object_type is inferred from info_field
  	#InfoValue.where('associated_object_type' = object.class).where('associated_object_id' = object.id)
  end

end
