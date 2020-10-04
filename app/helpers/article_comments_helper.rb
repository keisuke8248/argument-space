module ArticleCommentsHelper  

  def counting_evaluation(article_id, comment_id, key)
    evaluation = Evaluation.where(article_id: article_id, article_comment_id: comment_id)
    if evaluation.blank?
      return 0
    else
      sum = 0
      evaluation.each do |e|
        case key
        when "good"
          sum += e.good
        when "bad"
          sum += e.bad
        end
      end
    end
    return sum
  end
end
