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
    
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end  

    def current_user
      @current_user = current_user_session && current_user_session.record
    end
    
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
