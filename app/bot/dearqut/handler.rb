def add_message(message, options = {})
  text = options[:text] || message.text
  priv = !!options[:private]
  
  sender = message.user rescue message.sender
  user = User.find_or_create_by_twitter_user(sender)
  
  message          = Message.new
  message.user     = user
  message.private  = priv
  message.body     = text
  message.tweet_id = message.id
  
  message.save! && message
end
