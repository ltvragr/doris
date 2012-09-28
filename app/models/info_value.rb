class InfoValue < ActiveRecord::Base
  belongs_to :info_field_id
  attr_accessible :associated_object_id, :associated_object_type, :content
end
