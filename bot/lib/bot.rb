gem 'bjeanes-twibot', '>= 0.1.7'
require 'twibot'

configure do |c|
  c.login = 'dearqut'
  c.password = %Q(qm"60%$9.k?12N=[Q/C3?b^e`TLt}sg?H6uc`CWppmA]Hxk6C'2Q?bF$#Orfg1P)
  
  c.log_level = "error"
  
  c.process = Message.maximum(:tweet_id, :conditions => "tweet_id IS NOT NULL") || 0
  
  c.interval_step = 30
  c.min_interval = 30
  c.max_interval = 800
end

message do |message, params|
  puts %Q{Process this #{message.id}: "#{message}"}
end

reply do |message, params|
  if message.to_s =~ /^@dearqut\s+(.+)$/
    puts %Q{Process this #{message.id}: "#{$1}"}
  else
    puts %Q{Ignore this #{message.id}: "#{message}"}
  end
end