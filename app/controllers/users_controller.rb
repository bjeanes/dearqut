class UsersController < ApplicationController
  def new
    tab :signup
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    @user.creating_normal_user = true
    @user.login = params[:user][:login]
    @user.staff = params[:user][:staff]
    
    if @user.save
      self.current_user = @user
      flash[:notice] = "You have successfully created an account."
      flash[:notice] << " Your staff account will be activated after an admin confirms that you are a staff member." if @user.staff?
      redirect_to root_path
    else
      flash[:error] = "There was an error creating your account."
      if @user.errors.on(:email).to_s =~ /QUT/
        flash[:error] << " You must provide a staff email address to register a staff account."
      end
      render :action => :new
    end
  end

end
