class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @comment.save
    respond_to do |format|
      format.html { redirect_to group_path(params[:comment][:id])}
      format.json
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(group_id: params[:comment][:id],
                                                 user_id: current_user.id)
  end
end