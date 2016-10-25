class UsersController < ApplicationController
  before_action :set_params, only: [:show, :edit, :update]
  before_action :correct_user, only: [:edit, :update]
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
                                        :following, :followers]

  def show
    @microposts = @user.microposts.order(created_at: :desc)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new' 
    end
  end
  
  def edit
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user , notice: 'メッセージを編集しました'
    #更新に成功したときの処理
    else
      render 'edit'
    end
  end
  
  def followings
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following_users
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.follower_users
    render 'show_follow'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :location, :remarks)
  end
  
  def set_params
    @user = User.find(params[:id])
  end
  
  def correct_user
    redirect_to root_path if !current_user?(@user)
  end
end
