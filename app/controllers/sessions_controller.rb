# Pulled from twitter-auth gem to override some of the behaviour
class SessionsController < ApplicationController
  def new
    if twitter?
      @request_token = TwitterAuth.consumer.get_request_token
      session[:request_token] = @request_token.token
      session[:request_token_secret] = @request_token.secret
     
      url = @request_token.authorize_url
      url << "&oauth_callback=#{CGI.escape(TwitterAuth.oauth_callback)}" if TwitterAuth.oauth_callback?      
      redirect_to url
    else
      # we don't have to do anything, it's just a simple form for HTTP basic!
    end
  end
 
  def create
    # logout_keeping_session!
    if @user = User.authenticate(params[:login], params[:password])
      logger.info @user.inspect
      self.current_user = @user
      logger.info @current_user.inspect
      logger.info session.inspect
      
      authentication_succeeded
    else
      authentication_failed('Unable to verify your credentials. Please try again.', '/login')
    end
    logger.info session.inspect
  end
 
  def oauth_callback
    unless session[:request_token] && session[:request_token_secret] 
      authentication_failed('No authentication information was found in the session. Please try again.') and return
    end
    
   unless params[:oauth_token].blank? || session[:request_token] ==  params[:oauth_token]
     authentication_failed('Authentication information does not match session information. Please try again.') and return
   end
    
    @request_token = OAuth::RequestToken.new(TwitterAuth.consumer, session[:request_token], session[:request_token_secret])
    
    @access_token = @request_token.get_access_token

    @user = User.identify_or_create_from_access_token(@access_token)

    self.current_user = @user
 
    authentication_succeeded 
  rescue Net::HTTPServerException, Net::HTTPFatalError, TwitterAuth::Dispatcher::Error => e
    case e.message
      when '401 "Unauthorized"'
        authentication_failed('This authentication request is no longer valid. Please try again.') and return
      else
        authentication_failed('There was a problem trying to authenticate you. Please try again.') and return
    end 
  end
  
  def destroy
    logout_keeping_session!
    redirect_back_or_default('/')
  end
  
  protected
  def current_user=(user)
    session[:request_token] = nil
    session[:request_token_secret] = nil
    
    cookies[:remember_token] = user.remember_me
    super(user)
  end
  
  def twitter?
    TwitterAuth.oauth? && params[:twitter]
  end
end