class ArticlesController < ApplicationController
  before_action :set_secretKey
  require 'news-api'

  def index
    @news = @News.get_top_headlines(country: 'jp')
    @news.each do |n|
      Article.createArticles(title: n.title, url: n.url)
    end
  end

  def show
    category = view_context.categoryArray
    @news = @News.get_top_headlines(country: 'jp',
                                    category: category[params[:id].to_i])
    @news.each do |n|
      Article.createArticles(title: n.title, url: n.url)
    end
  end

  private

  def set_secretKey
    @News = News.new(ENV['NEWS_API_PRIVATE_KEY'])
  end

end
