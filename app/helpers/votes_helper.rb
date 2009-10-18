module VotesHelper
  
  def vote_link(direction, message)
    return unless [:agree, :disagree].include? direction
    
    count = direction == :agree ? 
              message.positive_vote_count : 
              message.negative_vote_count
    count = '(<span class="num">%s</span>)' % count
    image = vote_image(direction, user_vote_for(message))
    
    "#{image} #{count}"
  end
end
