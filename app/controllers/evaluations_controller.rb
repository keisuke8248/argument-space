class EvaluationsController < ApplicationController
  before_action :set_params

  def good
    Evaluation.evaluate(:good, "good", current_user.id, @article_id, @comment_id)
    sum = view_context.counting_evaluation(@article_id, @comment_id, "good")
    format(sum, @article_id, @comment_id)
  end

  def bad
    Evaluation.evaluate(:bad, "bad", current_user.id, @article_id, @comment_id)
    sum = view_context.counting_evaluation(@article_id, @comment_id, "bad")
    format(sum, @article_id, @comment_id)
  end

  def canceling_good
    Evaluation.canceling_evaluate(current_user.id, @article_id, @comment_id)
    sum = view_context.counting_evaluation(@article_id, @comment_id, "good")
    format(sum, @article_id, @comment_id)
  end

  def canceling_bad
    Evaluation.canceling_evaluate(current_user.id, @article_id, @comment_id)
    sum = view_context.counting_evaluation(@article_id, @comment_id, "bad")
    format(sum, @article_id, @comment_id)
  end

  private

  def set_params
    @article_id = params[:article_id]
    @comment_id = params[:comment_id]
  end

  def format(sum, article_id, comment_id)
    respond_to do |format|
      format.html { redirect_to article_article_comments_path(@article_id)}
      format.json { render json: { sum: sum , article_id: article_id, comment_id: comment_id} }
    end
  end

end
