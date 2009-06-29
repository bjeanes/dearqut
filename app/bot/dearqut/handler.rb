def add_message(m, options = {})
  text = options[:text] || m.text
  priv = !!options[:private]
  
  tweet_id = m.id
  sender   = m.user rescue m.sender
  user     = User.find_or_create_by_twitter_user(sender)
  
  message            = Message.new
  message.twitter    = true
  message.user       = user
  message.private    = priv
  message.body       = text
  message.tweet_id   = tweet_id
  message.created_at = m.created_at if m.created_at
  
  puts "@#{user.login} says: #{message.body}"
  
  message.save && message
end
