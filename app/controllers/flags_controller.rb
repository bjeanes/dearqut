class FlagsController < ApplicationController
  before_filter :get_message
  
  def new
    @flag = @message.flags.build
  end
  
  def create
    @flag      = @message.flags.build(params[:flag])
    @flag.user = current_user || nil
    @flag.ip   = request.remote_ip

    if @flag.save
      flash[:notice] = 'Message has been flagged for moderation'
      redirect_to(@message)
    else
      render :action => "new"
    end
  end
  
  protected
  
    def get_message
      @message = Message.find(params[:message_id])
    end
end
