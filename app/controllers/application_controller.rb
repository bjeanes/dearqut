# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  before_filter :check_for_banned_ip
  
  include TabFu
  helper :all
  protect_from_forgery
  tab :home

  filter_parameter_logging :password
  
  protected
  
    def anonymous?
      !logged_in?
    end
    
    def logged_in?
      current_user
    end
    
    def admin?
      current_user.admin? rescue false
    end
    
    def current_user_with_nil
      current_user_without_nil || nil
    end
    alias_method_chain :current_user, :nil
    
    def check_for_banned_ip
      if @ban = Ban.find_by_ip(request.ip)
        render "users/banned"        
        response.status = 403
      end
    end
    
    def user_agent
      request.env["HTTP_USER_AGENT"] || begin
        "Webrat" if %w(test cucumber).include?(Rails.env)
      end
    end
end
