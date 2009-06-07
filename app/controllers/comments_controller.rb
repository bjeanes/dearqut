class CommentsController < ApplicationController
  before_filter :get_message
  
  def index
    redirect_to @message
  end

  # POST /comments
  # POST /comments.xml
  def create
    @comment = Comment.new(params[:comment])

    respond_to do |format|
      if @comment.save
        flash[:notice] = 'Comment was successfully created.'
        format.html { redirect_to(@comment) }
        format.xml  { render :xml => @comment, :status => :created, :location => @comment }
      else
        format.html { render :action => "new" }
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
