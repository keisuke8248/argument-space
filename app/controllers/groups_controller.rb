class GroupsController < ApplicationController

  def index
    @groups = Group.all
    @group = Group.new
    @group.comments.build
    @group.images.build
  end

  def new

  end

  def show
    @group = Group.find(params[:id])
  end

  def create
    @group = Group.new(group_params)
    @group.save
    redirect_to root_path
  end

  private
  
  def group_params
    params.require(:group).permit( :title,
                                  comments_attributes: [:id, :group_id, :text],
                                  images_attributes: [:id, :group_id, :src])
  end
end
