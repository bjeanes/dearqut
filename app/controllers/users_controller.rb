class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    @user.login = params[:user][:login]
    
    if @user.save
      self.current_user = @user
      flash[:notice] = "You have successfully created an account"
      redirect_to root_path
    else
      render :action => :new
    end
  end

end
