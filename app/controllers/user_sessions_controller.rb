class UserSessionsController < ApplicationController
  # before_filter :require_no_user, :only => [:new, :create]
  # before_filter :require_user, :only => :destroy
  
  def new
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "You have logged in successfully."
      path = params[:redirect_to_admin] == 'true' ? admin_root_path : root_path
      redirect_back_or_default path
    else
      flash.now[:error] = "Unable to verify your credentials."
      render :action => 'new'
    end
  end
  
  def destroy
    @user_session = UserSession.find
    @user_session.destroy
    flash[:notice] = "You have logged out successfully."
    redirect_back_or_default root_url
  end
end