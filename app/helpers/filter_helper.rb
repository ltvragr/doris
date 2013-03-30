module FilterHelper

  def prepare_filter_bar
    # Prepares appropriate variables for the filter bar
    @sort_by_options = ['Project name', 'Date created', 'Lab name', 'Start date', 'End date']
  end

end