module UsersHelper

  def info_field_categories(fields)
    fields.inject([]) { |c, f| c << f.category unless c.include?(f.category); c}
  end

  def get_fields_for_category(category, fields)
    fields.inject([]) { |fs, f| fs << f if f.category == category; fs}.sort_by{ |f| f[:sort_order]}
  end
end
