class MessagesController < ApplicationController
  INDEX_VIEWS = %w{most_commented index popular latest_commented controversial}

  around_filter :load_tag, :only => INDEX_VIEWS

  before_filter :remove_tag_from_url, :only => :show
  before_filter :load_resources, :except => :random
  before_filter :permission_required, :except => INDEX_VIEWS + [:show, :new, :create, :random]

  INDEX_VIEWS.each do |view|
    define_method(view) do
      tab :browse
      
      if view == 'index' && params[:format] == 'rss' && 
         params[:feedburner] != 'true' && !tag?
        redirect_to 'http://feeds.feedburner.com/dearqut'
        return
      end

      render :action => :index
    end
  end
  
  def show
    @comments = @message.comments.ham
  end
  
  def new
    tab :home if request.path == '/'
    @message.user   = current_user
    @random_message = Message.ham.random
    @messages = Message.newest.ham.all(:limit => 5)
  end

  def create
    @message.user = current_user || nil
    @message.ip   = request.remote_ip
  
    if @message.save
      add_message_to_session
      flash[:notice] = 
        'Thank you for your message. <br /><br />
        Please add more information below, or <a href="%s">view your message</a>' % 
        message_path(@message)
      redirect_to(edit_message_path(@message))
    else
      new
      render :action => "new"
    end
  end
  
  def update
    if @message.update_attributes(params[:message])
      @message.update_attribute(:moderated, false) unless admin?
      @message.save!
      flash[:notice] = "Message updated successfully"
      redirect_to(@message)
    else
      render :action => "edit"
    end
  end
  
  def destroy
    @message.destroy
    redirect_to(messages_path)
  end
  
  def random
    redirect_to('/#random_message')
  end
  
  protected
    def load_tag
      if params[:tag_id]
        @tag = Tag.with_type_scope('Message') do
          Tag.find_by_id_or_name(params[:tag_id])
        end
        
        unless @tag
          flash[:error] = "No such tag or no messages use the tag"
          redirect_to messages_path
          return
        end
        
        Message.tagged_with_scope(@tag.name) { yield }
      else
        yield
      end
    end
    
    def remove_tag_from_url
      redirect_to message_path(params[:id].to_i) if tag?
    end
    
    def tag?
      !!@tag
    end
  
    def permission_required
      unless can_edit_message?(@message)
        flash[:error] = "You do not have permission to do that"
        redirect_to @message
      end
    end
    
    def can_edit_message?(message)
      admin? || message_in_session?(message) || (logged_in? && message.author?(current_user))
    end
    helper_method :can_edit_message?
    
    
    def load_resources
      if collection?
        @messages = case action_name
          when 'index'          then Message.newest
          when 'popular'        then Message.popular
          when 'most_commented' then Message.most_commented
          when 'latest_commented' then Message.latest_commented
          when 'controversial' then Message.most_controversial
        end.ham.paginate(:page => params[:page], :include => [:tags, :user])
      else
        @message = case action_name
          when 'new'    then Message.new
          when 'create' then Message.new(params[:message])
          else Message.ham.find(params[:id])
        end
      end
    end
    
    def collection?
      INDEX_VIEWS.include? action_name.to_s
    end
    
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
    
    def session_message_ids
      session[:message_ids] ||= []
    end
    
    def adding_context?
      !!params[:adding_context]
    end
end
