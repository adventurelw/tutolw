class RelationshipsController < ApplicationController
  respond_to :html, :js
  before_filter :unsigned_in_user
  #after_filter :respond_to_page #直接用这个就会出现redirect_to多次的错误

  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)
    respond_with @user
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    respond_with @user
  end
end
