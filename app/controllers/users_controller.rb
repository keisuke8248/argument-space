class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @evaluations = Evaluation.where(user_id: params[:id])
    @good = @evaluations.where(good: 1)
    @bad = @evaluations.where(bad: 1)
    @articleComments = ArticleComment.where(user_id: params[:id]).order("created_at DESC").limit(10)
  end
end
