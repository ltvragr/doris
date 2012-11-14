module UsersHelper

  def info_field_categories(fields)
    fields.inject([]) { |c, f| c << f.category unless c.include?(f.category); c}
  end

  def get_fields_for_category(category, fields)
    fields.inject([]) { |fs, f| fs << f if f.category == category; fs}.sort_by{ |f| f[:sort_order]}
  end

  def get_value_for_field(values, field, user)
    value = get_value_for_field_without_default(values, field, user)
    content = value.nil? ? field.content : value
    return content
  end

  def get_value_for_field_without_default(values, field, user)
    value = values.select {|value| value.associated_object_id == user.id && value.info_field_id == field.id}
    content = value.length == 1 ? value.first().content : nil
    return content
  end

  def get_field_as_array(field)
    entries = field.content.split(",")
  end
end
