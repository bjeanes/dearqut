require 'rubygems'
# require 'twibot'
require File.join(File.dirname(__FILE__), "twibot", "lib", "twibot")

begin
  configure do |c|
    c.login = 'dearqut'
    c.password = %Q(qm"60%$9.k?12N=[Q/C3?b^e`TLt}sg?H6uc`CWppmA]Hxk6C'2Q?bF$#Orfg1P)
  end

  message do |message, params|
    puts %Q{Process this: "#{message}"}
  end

  reply do |message, params|
    if message.to_s =~ /^@dearqut\s+(.+)$/
      puts %Q{Process this: "#{$1}"}
    else
      puts %Q{Ignore this: "#{message}"}
    end
  end
rescue => e
  puts e
end