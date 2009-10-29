class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update]

  def new
    tab :signup
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    
    @user.save do |result|
      if result
        flash[:notice] = "You have successfully created an account."
        flash[:notice] << " Your staff account will be activated after an admin confirms that you are a staff member." if @user.staff?
        redirect_back_or_default root_path
      else
        flash[:error] = "There was an error creating your account."
        if @user.errors.on(:email).to_s =~ /QUT/
          flash[:error] << " You must provide a staff email address to register a staff account."
        end
        render :action => :new
      end
    end
  end

end
