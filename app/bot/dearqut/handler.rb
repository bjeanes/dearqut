def add_message(message, options = {})
  text = options[:text] || message.text
  priv = !!options[:private]
  
  sender = message.user rescue message.sender
  user = User.find_or_create_by_twitter_user(sender)
  
  Message.create!(:user => user, :private => priv, :body => text, :tweet_id => message.id)
end