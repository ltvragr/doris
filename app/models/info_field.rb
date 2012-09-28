class InfoField < ActiveRecord::Base
  attr_accessible :associated_object, :associated_role, :category, :content, :content_type, :label, :sort_order
end
