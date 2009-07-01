xml.instruct! :xml, :version=>"1.0" 
xml.rss(:version=>"2.0") do
  xml.channel do
    xml.title("dearQUT Messages")
    xml.link("http://www.dearqut.com/")
    xml.description("Have something to tell QUT? Speak your mind and be heard at dearQUT")
    xml.language('en-us')
    
    @messages.each do |message|
      xml.item do
        xml.title("Dear QUT, #{message.author} has something to say!")
        xml.description(h(message.body))      
        xml.author(message.author)               
        xml.pubDate(message.created_at.rfc2822)
        xml.link(message_url(message))
        xml.guid(message_url(message))
      end
    end
  end
end