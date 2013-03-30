module LayoutHelper
  def title( page_title )
    content_for(:title) { page_title.to_s }
  end

  def subtitle( page_subtitle )
    content_for(:subtitle) { page_subtitle.to_s }
  end

# Used in the navbar in conjunction with currently_at to generate links in an
# active or inactive state.
  def nav_tab( title, url, options = {} )
    current_tab = options.delete(:current)
    options[:class] = (current_tab == title) ? 'active' : 'inactive'
    content_tag(:li, link_to(title, url), options)
  end

# Used on views to determine whether a navbar link should be active or not.
  def currently_at( tab )
    render partial: 'layouts/main_nav', locals: { current_tab: tab }
  end

end