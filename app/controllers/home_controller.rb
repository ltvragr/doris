class HomeController < ApplicationController
  def index
    @feed = Feedzirra::Feed.fetch_and_parse("http://news.yale.edu/topics/science-health/rss")
  end
end
