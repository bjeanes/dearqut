module Admin
  class DashboardController < BaseController

    def index
      message_stats
      moderation_stats
      staff_account_stats
    end

    private

    def moderation_stats
      spams = [["spam", Message.not_moderated.spam.count],
               ["need moderation", Message.moderate.not_moderated.count]]

      @message_moderation_count = spams.map do |type, count| 
         "#{count} #{type}" if count > 0
      end.compact.join(', ')
    end
    
    def staff_account_stats
      @unverified_staff_account_count = User.unverified_staff.count
      @verified_staff_account_count   = User.verified_staff.count
    end
    
    def message_stats
      @messages_count = Message.ham.count
      @comments_count = Comment.ham.count
      @votes_count    = Vote.count

      @comments_per_message = (@comments_count / @messages_count.to_f).round(2) rescue 0
      @votes_per_message    = (@votes_count    / @messages_count.to_f).round(2) rescue 0
    end
  end
end
