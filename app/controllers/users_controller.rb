class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @evaluation = Evaluation.where(user_id: params[:id])
    @good = @evaluation.where(good: 1)
    @bad = @evaluation.where(bad: 1)
    @articleComment = ArticleComment.where(user_id: params[:id]).order("created_at DESC").limit(10)
  end
end
