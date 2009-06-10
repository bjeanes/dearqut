# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include TabFu
  helper :all
  protect_from_forgery
  tab :home

  filter_parameter_logging :password
  
  protected
  
    def anonymous?
      current_user.nil?
    end
end
