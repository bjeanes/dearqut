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
    
    def can_edit_message?(message)
      admin? || message_in_session?(message) || (logged_in? && message.author?(current_user))
    end
    helper_method :can_edit_message?
    
    # This is so when users are anonymous they can still edit 
    # the message or assign it to their new account if they
    # are still in the same browser session
    def add_message_to_session
      session_message_ids << @message.id
    end
    
    # check if the current message was one created during
    # this browser session
    def message_in_session?(message)
      session_message_ids.include?(message.id)
    end
    
    def guest_message_conditions
      {:conditions => {:id => session_message_ids, :user_id => nil}}
    end
    
    def guest_messages
      Message.all(guest_message_conditions)
    end
    
    def has_guest_messages?
      Message.count(guest_message_conditions) > 0
    end
    
    def session_message_ids
      session[:message_ids] ||= []
    end

    def review_messages_or_go_home
      if has_guest_messages?
        flash[:notice] = "#{flash[:notice]} We have found a few messages that may belong to you."
        redirect_to review_messages_path
      else
        redirect_back_or_default root_path
      end
    end

end
