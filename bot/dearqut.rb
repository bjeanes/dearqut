require 'rubygems'
require 'twibot'

begin
  configure do |c|
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