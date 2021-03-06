class MessagesController < ApplicationController
  INDEX_VIEWS = %w{most_commented index popular latest_commented controversial search}

  around_filter :load_tag, :only => INDEX_VIEWS

  before_filter :remove_tag_from_url, :only => :show
  before_filter :load_resources, :except => [:random, :review]
  before_filter :permission_required, :except => INDEX_VIEWS + [:show, :new, :create, :random, :review]
  before_filter :require_user, :only => :review
  
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
    @comment = @message.comments.build
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
  
  def review
    redirect_to root_path if guest_messages.empty?
    @messages = guest_messages

    if request.post?
      (params[:messages] || {}).each do |message_id, choice|
        next if choice == 'not_mine'
        
        message         = Message.find(message_id, :conditions => {:user_id => nil}) || next
        message.user    = current_user
        message.private = true if choice == 'anonymous'
        message.save!
      end

      # if success
      flash[:notice] = "Messages processed successfully"
      session[:message_ids] = []
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
    
    def load_resources
      if collection?
        @messages = case action_name
          when 'index'            then Message.newest
          when 'popular'          then Message.popular
          when 'most_commented'   then Message.most_commented
          when 'latest_commented' then Message.latest_commented
          when 'controversial'    then Message.most_controversial
          when 'search'           then Message.search(params[:q])
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
    
    def adding_context?
      !!params[:adding_context]
    end
end
