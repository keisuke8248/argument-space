class ArticleCommentsController < ApplicationController
  before_action :set_params

  def index
    @comments = ArticleComment.includes(:article).where(article_id: @article_id)
    @article = Article.find(@article_id)
    @article_comments = ArticleComment.new
  end

  def index10
    comments = ArticleComment.includes(:article).where(article_id: @article_id)
    @comments = comments.order("created_at DESC").limit(10).reverse
    @article = Article.find(@article_id)
    @article_comments = ArticleComment.new
  end

  def create
    article_comment = ArticleComment.create(comments_params)
    id = article_comment.id
    length = ArticleComment.where(article_id: @article_id).length
    text = article_comment.text
    a = []

    (1..length).each do |i|
      if />>#{i}[^\d]/.match(text)
        ArticleCommentReply.create!(parent_article_comment_id: id,
          children_article_comment_id: i)
      end
    end

    article_comment.update(index: length.to_i)
    @new_comment = ArticleComment.where('article_id = ? and id > ? and id <= ?', 
                                        @article_id, @last_comment_id, article_comment.id)
    respond_to do |format|
      format.html { redirect_to article_article_comments_path(@article_id)}
      format.json
    end
  end

  def api
    @comments = ArticleComment.where('id > ? and article_id = ?', @last_comment_id, @article_id)
  end

  private

  def set_params
    @article_id = params[:article_id]
    @last_comment_id = params[:last_comment_id]
  end
  
  def comments_params
    params.require(:article_comment).permit(:text).merge(article_id: params[:article_id],
                                                                      user_id: current_user.id)
  end

end

