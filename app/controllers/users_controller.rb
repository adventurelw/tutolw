class UsersController < ApplicationController
  before_filter :unsigned_in_user, only: [:index, :edit, :update]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: :destroy
  before_filter :signed_in_user, only: [:new, :create]

  def index
    @users = User.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(create_params)
    if @user.save
      sign_in @user
      flash[:success] = "Great!!!!!"
      redirect_to @user
    else
      render "new"
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  def update
    if @user.update_attributes(create_params)
      flash[:success] = "Updated Successfully!!!!"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    if !current_user?(@user)
      @user.destroy
      flash[:success] = 'User destroyed.'
      redirect_to users_path
    else
      redirect_to root_path
    end
  end

  private
  def create_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  def unsigned_in_user
    unless signed_in?
      store_location
      redirect_to signin_path, notice: "Please sign in first!"
    end
  end

  def signed_in_user
    redirect_to root_path if signed_in?
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to root_path unless current_user?(@user)
  end

  def admin_user
    redirect_to root_path unless current_user.admin?
  end
end
