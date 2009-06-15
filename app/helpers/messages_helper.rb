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
  
  def agree_link(message)
    image = nil
    count = '(<span class="num">%s</span>)' % message.positive_vote_count
    
    if logged_in?
      if !current_user.voted?(message)       
        return %Q{<a href="" title="agree">#{image_tag 'agree.png'} #{count}</a>}
      elsif current_user.agreed?(message)
        image = image_tag('youagreed.png')
      end
    end
    
    %Q{#{image || image_tag('agree.png')} #{count}}
  end
  
  def disagree_link(message)
    image = nil
    count = '(<span class="num">%s</span>)' % message.negative_vote_count
    
    if logged_in?
      if !current_user.voted?(message)         
        return %Q{<a href="" title="Disagree">#{image_tag 'disagree.png'} #{count}</a>}
      elsif current_user.disagreed?(message)     
        image = image_tag('youdisagreed.png')
      end
    end
    
    %Q{#{image || image_tag('disagree.png')} #{count}}
  end
end
