module VotesHelper
  
  def vote_link(direction, message)
    return unless [:agree, :disagree].include? direction
    
    count = direction == :agree ? 
              message.positive_vote_count : 
              message.negative_vote_count
    count       = '(<span class="num">%s</span>)' % count
    image, text = vote_info(direction, user_vote_for(message))
    text        = '<span class="text">%s</span>' % text
    
    "#{text} #{image} #{count}"
  end
  
  protected
    def user_vote_for(message)
      if logged_in?
        message.votes.find_by_user_id(current_user.id)
      else
        message.votes.find_by_session_id(session[:session_id])
      end
    end
  
    def vote_info(direction, vote)
      text = if vote.nil? || !vote.direction?(direction)
        direction.to_s.titleize
      else
        "You #{direction}d"
      end
      
      img = "#{text.downcase.gsub(/\s/,'')}.png"
      
      return image_tag(img), text
    end
end
