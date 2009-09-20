class CommentsController < ApplicationController
  before_filter :get_message
  
  def index
    redirect_to @message unless params[:format] == "rss"
  end

  # POST /comments
  # POST /comments.xml
  def create
    @comment      = @message.comments.build(params[:comment])
    @comment.user = current_user
    @comment.ip   = request.remote_ip

    respond_to do |format|
      if @comment.save
        flash[:notice] = 'Comment was successfully posted.'
        format.html { redirect_to(@message) }
        format.xml  { render :xml => @comment, :status => :created, :location => @comment }
      else
        format.html { render :controller => "messages", :action => "show", :id => @message }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # # PUT /comments/1
  # # PUT /comments/1.xml
  # def update
  #   @comment = Comment.find(params[:id])
  # 
  #   respond_to do |format|
  #     if @comment.update_attributes(params[:comment])
  #       flash[:notice] = 'Comment was successfully updated.'
  #       format.html { redirect_to(@comment) }
  #       format.xml  { head :ok }
  #     else
  #       format.html { render :action => "edit" }
  #       format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
  #     end
  #   end
  # end
  # 
  # # DELETE /comments/1
  # # DELETE /comments/1.xml
  # def destroy
  #   @comment = Comment.find(params[:id])
  #   @comment.destroy
  # 
  #   respond_to do |format|
  #     format.html { redirect_to(comments_url) }
  #     format.xml  { head :ok }
  #   end
  # end
  
  protected
  
    def get_message
      @message = Message.find(params[:message_id])
    end
end
