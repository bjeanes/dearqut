class Admin::SpamController < AdminController
  before_filter :fetch_message, :only => [:show, :update]
  
  def index
    @messages = Message.all(
                  :conditions => {
                    :spam_status => ["spam", "moderate"], 
                    :moderated => false}, 
                  :order => :spam_status).paginate
                  
    spams = [["spam", Message.spam.count],
             ["need moderation", Message.moderate.count]]

    @message_moderation_count = spams.map do |type, count| 
       "#{count} #{type}" if count > 0
    end.flatten.join(', ')
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
    end
    
    @message.moderated = true
    
    if @message.save
      flash[:success] = "You have successfully marked that message as #{type}."
      redirect_to admin_spam_index_path
    else
      flash[:error] = "The message could not be marked as #{type}. :("
      redirect_to admin_spam_path(@message)
    end
  end
  
  private
  
    def fetch_message
      @message = Message.find(params[:id], 
        :conditions => {
          :spam_status => ["spam", "moderate"],
          :moderated => false})
    end
end