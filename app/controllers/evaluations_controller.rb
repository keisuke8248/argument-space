class EvaluationsController < ApplicationController

  def good
    evaluate(:good)
  end

  def bad
    evaluate(:bad)
  end

  private

  def evaluate(key)
    evaluation = Evaluation.find_by(user_id: current_user.id,
                                    article_id: params[:article_id],
                                    article_comment_id: params[:comment_id])
    if evaluation.blank?
      evaluation = Evaluation.new(user_id: current_user.id,
                                  article_id: params[:article_id],
                                  article_comment_id: params[:comment_id]
                                  )
      evaluation.save!
    end
    evaluation.increment!(key, 1)
  end

end
