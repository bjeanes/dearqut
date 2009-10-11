class Admin::DashboardController < AdminController

  def index
    @messages_count = Message.ham.count
    @comments_count = Comment.ham.count
    @votes_count    = Vote.count

    @comments_per_message = (@comments_count / @messages_count.to_f).round(2) rescue 0
    @votes_per_message    = (@votes_count    / @messages_count.to_f).round(2) rescue 0
    
    spams = [["spam", Message.spam.count],
             ["need moderation", Message.moderate.count]]

    @message_moderation_count = spams.map do |type, count| 
       "#{count} #{type}" if count > 0
    end.flatten.join(', ')
  end

end
