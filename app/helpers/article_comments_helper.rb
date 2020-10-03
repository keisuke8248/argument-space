module ArticleCommentsHelper
  
  def article_comment_id(article_id, comment_id)
    array = ArticleComment.where(article_id: article_id)
    return array.ids.index(comment_id)
  end

end
