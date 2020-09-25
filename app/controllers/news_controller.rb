class NewsController < ApplicationController
  before_action :set_secretKey
  require 'news-api'

  def index
    @news = @News.get_top_headlines(country: 'jp')
  end

  def show
    category = view_context.categoryArray
    @news = @News.get_top_headlines(country: 'jp',
                                    category: category[params[:id].to_i])
  end

  private

  def set_secretKey
    @News = News.new(ENV['NEWS_API_PRIVATE_KEY'])
  end

end
