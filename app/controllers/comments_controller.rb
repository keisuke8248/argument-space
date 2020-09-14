class CommentsController < ApplicationController
  def index
    comment = Comment.find_by(group_id: params[:group_id])
    @title = comment.group.title
    @group_images = comment.group.group_images
    @comments = Comment.where(group_id: params[:group_id])
    @group = Group.find(params[:group_id])
    @comment = Comment.new
    #@comment.comment_images.build
  end

  def create
    @comment = Comment.new(comment_params)
    #binding.pry
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