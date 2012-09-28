class InfoField < ActiveRecord::Base
  attr_accessible :associated_object, :associated_role, :category, :content, :content_type, :label, :sort_order

  def prepare_form_helpers
    if display_type == "text"
      return ["data_fields", id, {:id => id}]
    elsif display_type == "paragraph_text"
      return ["data_fields", id]
    elsif display_type == "select_box"
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
