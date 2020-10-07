module ApplicationHelper

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
      return sum
    end
  end

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
