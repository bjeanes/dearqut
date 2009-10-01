class AdminController < ApplicationController
  before_filter :admin_required
  layout 'admin'
  
  def index
    
  end
  
  private
  
  def admin_required
    unless current_user && current_user.admin?
      session[:return_to_admin] = true
      render :text => "", :layout => 'login'
    end
  end
end