class CommentsController < ApplicationController
  def index
    @comment = Comment.find_by(group_id: params[:group_id])
    @title = @comment.group.title
    @group_images = @comment.group.group_images
    @comments = Comment.where(group_id: params[:group_id])
    @group = Group.find(params[:group_id])
    @comment = Comment.new
    @comment.comment_images.build
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to group_comments_path(params[:group_id])
    else
      
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:id, :text, :group_id,
                             comment_images_attributes: [:src]).merge(group_id: params[:group_id])
  end

end
