class ArticleCommentsController < ApplicationController
  before_action :set_params
  before_action :find_comments, only: [:index, :index10]
  before_action :find_articles, except: [:api]

  def index
    @article_comments = ArticleComment.new
  end

  def index10
    @comments = @comments.order("created_at DESC").limit(10).reverse
    @article_comments = ArticleComment.new
  end

  def show
    @comment = ArticleComment.find(params[:id])
    @article_comments = ArticleComment.new

  end

  def create
    posted_comment = ArticleComment.create(comments_params)
    length = ArticleComment.where(article_id: @article_id).length
    posted_comment.update(index: length.to_i)
    parent_id = posted_comment.id
    anchors1 = posted_comment.text.scan(/(?<=\>>)\d+/).uniq
    if anchors1[0].present?
      anchors1.each do |a|
        children = ArticleComment.find_by(article_id: @article_id, index: a)
        children_id = children.id
        ArticleCommentReply.create(parent_article_comment_id: parent_id,
                                   children_article_comment_id: children_id)
      end
    end

    @new_comment = ArticleComment.includes(:user).where('article_id = ? and id > ? and id <= ?', 
                                                        @article_id, @last_comment_id, posted_comment.id)
    @anchors= []
    @new_comment.each do |c|
      arrayAnchors(c, @anchors)
    end
    respond_to do |format|
      format.html { redirect_to article_article_comments_path(@article_id)}
      format.json
    end
  end

  def api
    @comments = ArticleComment.where('id > ? and article_id = ?', @last_comment_id, @article_id)
    @anchors = []
    @comments.each do |c|
      arrayAnchors(c, @anchors)
    end
  end

  private

  def set_params
    @article_id = params[:article_id]
    @last_comment_id = params[:last_comment_id]
  end

  def find_comments
    @comments = ArticleComment.includes(:article, :user).where(article_id: @article_id)
  end

  def find_articles
    @article = Article.find(@article_id)
  end
  
  def comments_params
    params.require(:article_comment).permit(:text).merge(article_id: params[:article_id],
                                                                      user_id: current_user.id)
  end

  def arrayAnchors(c, anchors)
    replies = ArticleCommentReply.where(parent_article_comment_id: c.id)
    array = []
    replies.each do |reply|
      childrenId = reply.children_article_comment_id
      children = ArticleComment.where(id: childrenId)
      children.each do |child|
      index = child.index
        if index == nil
          array.push(nil)
        else
          array.push(index)
        end
      end
      anchors.push(array)
    end
  end

end

