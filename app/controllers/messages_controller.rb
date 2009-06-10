class MessagesController < ApplicationController
  before_filter :load_resources
  before_filter :permission_required, :except => [:index, :show, :new, :create]
  
  tab :browse
  
  # GET /messages
  # GET /messages.xml
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @messages }
    end
  end

  # GET /messages/new
  # GET /messages/new.xml
  def new
    tab :home if request.path == '/'
  end

  # POST /messages
  # POST /messages.xml
  def create
    @message.user = current_user
  
    if @message.save
      add_message_to_session
      flash[:notice] = 'Thank you for your message.'
      redirect_to(add_context_message_path(@message))
    else
      render :action => "new"
    end
  end
  
  def update
    if @message.update_attributes(params[:message])
      redirect_to(@message)
    else
      render :action => update_error_action
    end
  end
  
  protected
    def permission_required
      message_in_session? || @message.author?(current_user)
    end
  
    def load_resources
      if collection?
        @messages = Message.all
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
    
    def update_error_action
      if adding_context?
        "add_context"
      else
        "edit"
      end
    end
end
