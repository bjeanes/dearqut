module My
  class BaseController < ApplicationController
    before_filter :login_required
    
    private
    
    def login_required
      redirect_to(new_session_path) unless current_user
    end
    
  end
end