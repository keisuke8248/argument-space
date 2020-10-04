class ArticleCommentsController < ApplicationController

  def index
    @comments = ArticleComment.includes(:article).where(article_id: params[:article_id])
    @article = Article.find(params[:article_id])
    @article_comments = ArticleComment.new
  end

  def create
    article_comment = ArticleComment.create(comments_params)
    @new_comment = ArticleComment.where('article_id = ? and id > ? and id <= ?', 
                                        params[:article_id], params[:last_comment_id], article_comment.id)
    respond_to do |format|
      format.html { redirect_to article_article_comments_path(params[:article_id])}
      format.json
    end
  end

  def api
    last_comment_id = params[:last_comment_id]
    article_id = params[:article_id]
    @comments = ArticleComment.where('id > ? and article_id = ?', last_comment_id, article_id)
  end

  private
  
  def comments_params
    params.require(:article_comment).permit(:text).merge(article_id: params[:article_id],
                                                                      user_id: current_user.id)
  end

end

