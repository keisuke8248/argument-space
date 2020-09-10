class CommentsController < ApplicationController
  def index
    @comments = Comment.find_by(group_id: params[:id])
  end
end
