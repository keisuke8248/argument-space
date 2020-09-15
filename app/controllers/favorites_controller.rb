class FavoritesController < ApplicationController
  before_action :set_params

  def create
    favorite = Favorite.find_by(user_id: @user, comment_id: @comment)
    unless favorite.present?
      favorite = Favorite.new(favorite_params)
      favorite.save
    else
      favorite.increment!(:vote, 1)
    end
    #json形式で返すよう実装する予定
    #voteカラムの値をjbuilderに渡してビュー構築の条件分岐をしたい
  end


  private

  def set_params
    @user = params[:favorite][:user_id]
    @comment = params[:favorite][:comment_id]
  end

  def favorite_params
    params.require(:favorite).permit(:vote).merge(user_id: @user, 
                                                  comment_id: @comment)
  end
end
