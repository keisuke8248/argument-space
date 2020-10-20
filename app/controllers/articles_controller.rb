class ArticlesController < ApplicationController
  before_action :set_secretKey
  before_action :set_articleComments
  require 'news-api'

  def index
    @news = @News.get_top_headlines(country: 'jp')
    create_articles
  end

  def show
    category = view_context.categoryArray
    @news = @News.get_top_headlines(country: 'jp',
                                    category: category[params[:id].to_i])
    create_articles
  end

  private

  def set_secretKey
    @News = News.new(ENV['NEWS_API_PRIVATE_KEY'])
  end
  
  def create_articles
    @news.each do |n|
      if n.author == "netkeiba.com"
        Article.createArticles(title: n.title, url: n.url, author: n.author, publishedAt: n.publishedAt, urlToImage: n.urlToImage)
      else
        Article.createArticles(title: n.title, url: n.url, description: n.description, author: n.author, publishedAt: n.publishedAt, urlToImage: n.urlToImage)
      end
    end
  end

  def set_articleComments
    @articleComments = ArticleComment.order('id DESC').limit(15)
  end

end
