# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  delegate :anonymous?, :admin?, :current_user, :logged_in?, :to => :controller
  
  def tag_path(tag)
    # save a redirect
    tag_messages_path(tag)
  end
  
  def rss_feeds
    feeds =  auto_discovery_link_tag(:rss, 
                "http://feeds.feedburner.com/dearqut", 
                :title => "Newest Messages")

    if @messages && controller_name == "messages" && action_name != "index" && !@tag
      feeds << auto_discovery_link_tag(:rss, {:format => :rss})
    end
    
    if @tag
      feeds << auto_discovery_link_tag(:rss, {:format => :rss}, :title => "Messages for tag #{@tag.name}")
    end
    
    if @message && @comments
      feeds << auto_discovery_link_tag(:rss, 
        message_comments_url(@message, :format => :rss),
        :title => "Comments for this message")
    end
    
    feeds
  end
end
