class MicropostsController < ApplicationController
  before_filter :unsigned_in_user, only: [:create, :destroy]
  before_filter :correct_user, only: :destroy

  def create
    @micropost = current_user.microposts.build(create_params)
    if @micropost.save
      flash[:success] = 'Micropost created!'
      redirect_to root_path
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    redirect_to root_path
  end

  private
  def create_params
    params.require(:micropost).permit(:content)
  end

  def correct_user
    @micropost = current_user.microposts.find_by_id(params[:id])
    redirect_to root_path if @micropost.nil?
  end
end
