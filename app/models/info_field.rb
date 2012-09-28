class InfoField < ActiveRecord::Base
  DISPLAY_TYPE_OPTIONS = { "Text Field"   => "text_field",
                           "Paragraph Text"    => "text_area",
                           "Select from a List"   => "select",
                           "Multiple Choice" => "radio_button",
                           "Check Boxes" => "check_box"}
  ASSOCIATED_OBJECT_OPTIONS = { "User" => "user",
  							    "Lab" => "lab"}

  ASSOCIATED_ROLE_OPTIONS = { 	"Undergrad"   => "undergrad",
                   	"PI"    => "pi",
					"Graduate Student"   => "graduate"}

  attr_accessible :associated_object, :associated_role, :category, :content, :content_type, :label, :sort_order
end
