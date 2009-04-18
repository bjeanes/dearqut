gem 'bjeanes-twibot', '>= 0.1.7'
require 'twibot'

configure do |c|
  c.login = 'dearqut'
  c.password = %Q(qm"60%$9.k?12N=[Q/C3?b^e`TLt}sg?H6uc`CWppmA]Hxk6C'2Q?bF$#Orfg1P)
  
  c.log_level = "error"
  
  c.process = Message.maximum(:tweet_id, :conditions => "tweet_id IS NOT NULL") || 0
  puts "Starting from tweet ##{c.process}"
  
  c.min_interval = 30  # 30 seconds
  c.max_interval = 600 # 10 minutes
  
  # Increase by 30 seconds after each empty request
  c.interval_step = 30
end

message do |message, params|
  add_message(message, :private => true)
end

reply do |message, params|
  # Only process replies that begin with @dearqut
  add_message(message, :text => $1) if message.to_s =~ /^@dearqut\s+(.+)$/
end