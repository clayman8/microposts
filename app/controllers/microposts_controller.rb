class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  
  def  create
    @micropost = current_user.microposts.build(microposts_params)
    if @micropost.save
      flash[:success] = "Microposts created!"
      redirect_to root_url
    else
      @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc).page(params[:page])
      render 'static_pages/home'
    end
  end
  
  def destroy
    @micropost = current_user.microposts.find_by(id: params[:id])
    return redirect_to root_url if @micropost.nil?
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url
  end
  
  private
  def microposts_params
    params.require(:micropost).permit(:content)
  end
end
