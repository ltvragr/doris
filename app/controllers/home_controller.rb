class HomeController < ApplicationController
  def index
    @feed = Feedzirra::Feed.fetch_and_parse("http://news.yale.edu/topics/science-health/rss")
    @feed2 = Feedzirra::Feed.fetch_and_parse("http://feeds.sciencedaily.com/sciencedaily/top_news/top_science")
  end
end
