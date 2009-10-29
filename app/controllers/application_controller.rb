# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include ::Auth
  
  before_filter :check_for_banned_ip
  
  include TabFu
  helper :all
  protect_from_forgery
  tab :home
    
  protected
    
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
