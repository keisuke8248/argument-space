class ArticleCommentsController < ApplicationController

  def index
    @comments = ArticleComment.where(article_id: params[:article_id])
    @article = Article.find(params[:article_id])
    @article_comments = ArticleComment.new
    #binding.pry
  end

  def create
    ArticleComment.create(comments_params)
    redirect_to article_article_comments_path(params[:article_id])
  end

  private
  
  def comments_params
    params.require(:article_comment).permit(:text).merge(article_id: params[:article_id],
                                                                      user_id: current_user.id)
  end

end
