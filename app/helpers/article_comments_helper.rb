module ArticleCommentsHelper

  def myEvaluation(article_id, comment_id)
    evaluation = Evaluation.find_by(article_id: article_id, article_comment_id: comment_id, user_id: current_user.id)
    if evaluation.blank?
      return "blank"
    elsif evaluation.good == 1
      return "good"
    elsif evaluation.bad == 1
      return "bad"
    end
  end

  def replyCount(id)
    reply = ArticleCommentReply.where(children_article_comment_id: id)
    return reply.length
  end

  def getReplies(id)
    a = []
    reply = ArticleCommentReply.where(children_article_comment_id: id)
    reply.each do |r|
      id = r.parent_article_comment_id
      a << ArticleComment.find(id)
    end
    return a
  end
end
