module MessagesHelper
  def tag_sentence(tags)
    sentence = tags.map { |tag| link_to_tag(tag) }.to_sentence.strip
    sentence = '<em>none</em>' if sentence.blank?
    sentence
  end
  
  def message_time(message)
    if Time.now - @message.created_at < 5.minutes
      Time.now.to_s(:short)
    else
      "<del>#{@message.created_at.to_s(:short)}</del>
       <ins>#{Time.now.to_s(:short)}</ins>"
    end
  end
  
  def message_body(message, char=160, more="...")
    if controller.action_name == "show"
      h(message.body)
    else
      link_to h(truncate(message.body, :length => char, :omission => more )), message
    end
  end
  
  def vote_link(direction, message)
    return unless [:agree, :disagree].include? direction
    
    count = direction == :agree ? 
              message.positive_vote_count : 
              message.negative_vote_count
    count = '(<span class="num">%s</span>)' % count
    image = vote_image(direction, user_vote_for(message))
    
    %Q{<a href="" title="agree">#{image} #{count}</a>}
  end
  
  protected
    def user_vote_for(message)
      if logged_in?
        message.votes.find_by_user_id(current_user.id)
      else
        message.votes.find_by_session_id(session[:session_id])
      end
    end
  
    def vote_image(direction, vote)
      img = if vote.nil? || !vote.direction?(direction)
        "#{direction}.png"
      else
        "you#{direction}d.png"
      end
      
      image_tag(img)
    end
end
