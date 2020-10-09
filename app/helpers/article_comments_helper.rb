module ArticleCommentsHelper

  def my_evaluation(article_id, comment_id)
    evaluation = Evaluation.find_by(article_id: article_id, article_comment_id: comment_id, user_id: current_user.id)
    if evaluation.blank?
      return "blank"
    elsif evaluation.good == 1
      return "good"
    elsif evaluation.bad == 1
      return "bad"
    end
  end

end
