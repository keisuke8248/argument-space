class GroupsController < ApplicationController

  def index
    @groups = Group.all.includes(:user)
    @group = Group.new
    @group.comments.build
    @group.group_images.build
  end

  def new

  end

  def show
    @group = Group.find(params[:id])
    @comments = @group.comments.includes(:user)
    @group_image = @group.group_images
    @comment = Comment.new
    @favorite = Favorite.new

  end

  def create
    @group = Group.new(group_params)
    @group.save
    redirect_to root_path
  end

  def api
    @group = Group.find(params[:id])
    last_comments_id = params[:id]
    @comments = @group.comments.includes(:user)
  end

  private
  
  def group_params
    params.require(:group).permit( :title,
                                  group_images_attributes: [:src]).reverse_merge(user_id: current_user.id,
                                                                                 comments_attributes: [user_id: current_user.id,
                                                                                                       text: params[:group][:comments_attributes][:"0"][:text]])
  end
end