class Admin::SpamController < AdminController
  def index
    @messages = Message.all(
                  :conditions => {:spam_status => ["spam", "moderate"]}, 
                  :order => :spam_status).paginate
                  
    spams = [["spam", Message.spam.count],
             ["need moderation", Message.moderate.count]]

    @message_moderation_count = spams.map do |type, count| 
       "#{count} #{type}" if count > 0
    end.flatten.join(', ')
  end
end