xml.instruct! :xml, :version=>"1.0" 
xml.rss(:version=>"2.0") do
  xml.channel do
    xml.title("dearQUT Comments For Message ##{@message.id} from #{@message.author}")
    xml.link(message_url(@message))
    xml.description("Have something to tell QUT? Speak your mind and be heard at dearQUT")
    xml.language('en-us')
    
    @message.comments.each do |comment|
      xml.item do
        xml.title("Comment from #{comment.author}")
        xml.description(h(comment.body))      
        xml.author(comment.author)               
        xml.pubDate(comment.created_at.rfc2822)
        xml.link(message_url(@message) + "#comment-#{comment.id}")
        xml.guid(message_url(@message) + "#comment-#{comment.id}")
      end
    end
  end
end