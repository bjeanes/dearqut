class MessagesController < ApplicationController
  before_filter :load_resources, :except => :random
  before_filter :permission_required, :except => [:index, :show, :new, :create, :random]
  

  def index
    tab :browse
  end
  
  def new
    tab :home if request.path == '/'
    @random_message = Message.random
  end

  def create
    @message.user = current_user
  
    if @message.save
      add_message_to_session
      flash[:notice] = 
        'Thank you for your message. <br /><br />
        Please add more information below, or <a href="%s">view your message</a>' % 
        message_path(@message)
      redirect_to(add_context_message_path(@message))
    else
      render :action => "new"
    end
  end
  
  def update
    if @message.update_attributes(params[:message])
      redirect_to(@message)
    else
      render :action => "edit"
    end
  end
  
  def random
    redirect_to('/#random_message')
  end
  
  protected
    def permission_required
      unless message_in_session? || @message.author?(current_user)
        flash[:error] = "You do not have permission to do that"
        redirect_to @message
      end
    end
  
    def load_resources
      if collection?
        @messages = Message.all(:include => [:tags, :user])
      else
        @message = case action_name
          when 'new' then Message.new
          when 'create' then Message.new(params[:message])
          else Message.find(params[:id])
        end
      end
    end
    
    def collection?
      action_name == 'index'
    end
    
    # This is so when users are anonymous they can still edit 
    # the message or assign it to their new account if they
    # are still in the same browser session
    def add_message_to_session
      session_message_ids << @message.id
    end
    
    # check if the current message was one created during
    # this browser session
    def message_in_session?
      session_message_ids.include? @message.id
    end
    
    def session_message_ids
      session[:message_ids] ||= []
    end
    
    def adding_context?
      !!params[:adding_context]
    end
end
