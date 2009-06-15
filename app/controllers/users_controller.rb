class UsersController < ApplicationController
  def new
    tab :signup
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    @user.creating_normal_user = true
    @user.login = params[:user][:login]
    
    if @user.save
      self.current_user = @user
      flash[:notice] = "You have successfully created an account"
      redirect_to root_path
    else
      flash[:error] = "There was an error creating your account :("
      render :action => :new
    end
  end

end
