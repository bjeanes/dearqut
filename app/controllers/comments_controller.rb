class CommentsController < ApplicationController
  before_filter :get_message
  
  def index
    redirect_to @message unless params[:format] == "rss"
  end

  # POST /comments
  # POST /comments.xml
  def create
    @comment      = @message.comments.build(params[:comment])
    @comment.user = current_user || nil
    @comment.ip   = request.remote_ip

    if @comment.save
      flash[:notice] = 'Comment was successfully posted.'
      redirect_to(@message)
    else
      render :controller => "messages", :action => "show", :id => @message
    end
  end
  
  protected
  
    def get_message
      @message = Message.find(params[:message_id])
    end
end
