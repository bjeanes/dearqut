module Admin
  class BaseController < ApplicationController
    before_filter :admin_required
    layout 'admin'
  
    private
    def admin_required
      unless current_user && current_user.admin?
        session[:return_to_admin] = true
        render :text => "", :layout => 'login'
      end
    end
  end
end