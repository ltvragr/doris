class InfoValue < ActiveRecord::Base
  belongs_to :info_field

  attr_accessible :associated_object_id, :associated_object_type, :content

  def self.sorted_values_for_object(object)
  	#TODO This should  be re-written so that object_type is inferred from info_field
  	InfoValue.where('associated_object_id' => object.id).select{|iv| iv.info_field.associated_object == object.class.name}
  end

end
