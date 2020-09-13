class GroupsController < ApplicationController

  def index
    @groups = Group.all
    @group = Group.new
    @group.comments.build
    @group.group_images.build
  end

  def new

  end

  def show
    @group = Group.find(params[:id])
  end

  def create
    @group = Group.new(group_params)
    #binding.pry
    @group.save
    redirect_to root_path
  end

  private
  
  def group_params
    params.require(:group).permit( :title,
                                  comments_attributes: [:id, :group_id, :text],
                                  group_images_attributes: [:src])
  end
end
