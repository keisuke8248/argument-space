class ArticleCommentsController < ApplicationController

  def index
    @comments = ArticleComment.where(article_id: params[:article_id])
    @article = Article.find(params[:article_id])
    @article_comments = ArticleComment.new
    #binding.pry
  end

  def create
    article_comment = ArticleComment.create(comments_params)
    @new_comment = ArticleComment.where('article_id = ? and id > ? and id <= ?', params[:article_id], params[:last_comment_id], article_comment.id)
    #binding.pry
    respond_to do |format|
      format.html { redirect_to article_article_comments_path(params[:article_id])}
      format.json
    end
  end

  private
  
  def comments_params
    params.require(:article_comment).permit(:text).merge(article_id: params[:article_id],
                                                                      user_id: current_user.id)
  end

end
