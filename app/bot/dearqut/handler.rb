def add_message(message, options = {})
  text = options[:text] || message.text
  priv = !!options[:private]
  
  tweet_id = message.id
  sender = message.user rescue message.sender
  user = User.find_or_create_by_twitter_user(sender)
  
  message          = Message.new
  message.twitter  = true
  message.user     = user
  message.private  = priv
  message.body     = text
  message.tweet_id = tweet_id
  
  message.save && message
end
