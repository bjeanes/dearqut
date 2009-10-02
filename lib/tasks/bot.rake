namespace :bot do
  desc "Start the DearQUT bot"
  task :start do
    if running?
      puts "Bot is already running"
    else
      puts "Starting the bot"
      ENV['RAILS_ENV'] ||= 'development'
      %x(screen -d -m ruby app/bot/dearqut.rb)
    end
  end
  
  desc "Stop the DearQUT bot"
  task :stop do
    if running?
      puts "Stopping the bot"
      pid = `cat tmp/pids/bot.pid 2>/dev/null`.chomp
      `kill #{pid} 2>/dev/null || echo 'Already stopped'` if $?.success?
    else
      puts "Bot is not running"
    end
  end
  
  desc "Restarts the DearQUT bot"
  task :restart => [:stop, :start]
  
  def running?
    %x(ps aux | grep app/bot/dearqut.rb | grep -v grep | wc -l).strip.to_i > 0
  end
end