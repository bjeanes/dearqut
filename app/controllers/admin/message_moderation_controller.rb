module Admin
  class MessageModerationController < BaseController
    before_filter :fetch_message, :only => [:show, :update]
  
    def index
      @messages = Message.needs_moderation.paginate(:page => params[:page])
                  
      moderates = [["spam", Message.not_moderated.spam.count],
               ["need moderation", Message.not_moderated.moderate.count]]

      @message_moderation_count = moderates.map do |type, count| 
         "#{count} #{type}" if count > 0
      end.compact.join(', ')
    end
  
    def show
      @message.send :calculate_snook_score
    end
  
    def update
      type = if params[:ham]
        @message.ham!
        'ham'
      elsif params[:spam]
        @message.spam!
        'spam'
      elsif params[:cull]
        @message.cull!
        'cull'
      end
      
    
      @message.moderated = true
    
      if @message.save
        flash[:success] = "You have successfully marked that message as #{type}."
        redirect_to admin_message_moderation_index_path
      else
        flash[:error] = "The message could not be marked as #{type}. :("
        redirect_to admin_message_moderation_path(@message)
      end
    end
  
    private
  
      def fetch_message
        @message = Message.needs_moderation.find(params[:id])
      end
  end
end