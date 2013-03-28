class InfoField < ActiveRecord::Base
  DISPLAY_TYPE_OPTIONS = {   "Text Field" => "text_field",
                         "Paragraph Text" => "text_area",
                     "Select from a List" => "select",
                        "Multiple Choice" => "radio_button",
                            "Check Boxes" => "check_box"}
  
  ASSOCIATED_OBJECT_OPTIONS = {    "User" => "User",
					                          "Lab" => "Lab"}

  ASSOCIATED_ROLE_OPTIONS = { "Undergrad" => "undergrad",
                                     "PI" => "pi",
				               "Graduate Student" => "graduate"}

  attr_accessible :associated_object, :associated_role, :category, :content, :content_type, :label, :sort_order
  has_many :info_values


# this is only copied from Shifts now. need to actually implement on top of this when we do views.
  def prepare_form_helpers
    if display_type == "text_field"
      return ["data_fields", id, {id: id}]
    elsif display_type == "text_area"
      return ["data_fields", id]
    elsif display_type == "select"
      options = values.split(',').each{|opt| opt.squish!}
      return ["data_fields", id, options.map{|opt| [opt, opt]}]
    elsif display_type == "check_box"
      options = values.split(',').each{|opt| opt.squish!}
      return options.map{|v| ["data_fields[#{id}]", v]}
    elsif display_type == "radio_button"
      options = values.split(',').each{|opt| opt.squish!}
      return options.map{|v| ["data_fields[#{id}]", 1, v]}
    end
  end

end
