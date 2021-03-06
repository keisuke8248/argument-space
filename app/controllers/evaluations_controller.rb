class EvaluationsController < ApplicationController
  before_action :set_params

  def good
    Evaluation.evaluate(:good, current_user.id, @children_user_id, @comment_id)
    sum = view_context.counting_evaluation(@comment_id, "good")
    format(sum, @comment_id)
  end

  def bad
    Evaluation.evaluate(:bad, current_user.id, @children_user_id, @comment_id)
    sum = view_context.counting_evaluation(@comment_id, "bad")
    format(sum, @comment_id)
  end

  def canceling_good
    Evaluation.canceling_evaluate(current_user.id, @comment_id)
    sum = view_context.counting_evaluation(@comment_id, "good")
    format(sum, @comment_id)
  end

  def canceling_bad
    Evaluation.canceling_evaluate(current_user.id, @comment_id)
    sum = view_context.counting_evaluation(@comment_id, "bad")
    format(sum, @comment_id)
  end

  private

  def set_params
    @comment_id = params[:comment_id]
    @children_user_id = ArticleComment.includes(:user).find(@comment_id).user_id
  end

  def format(sum, comment_id)
    respond_to do |format|
      format.html { redirect_to article_article_comments_path(@article_id)}
      format.json { render json: { sum: sum , comment_id: comment_id} }
    end
  end

end
