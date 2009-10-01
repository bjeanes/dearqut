namespace :bot do
  desc "Start the DearQUT bot"
  task :start do
    puts "Starting the bot"
    ENV['RAILS_ENV'] ||= 'development'
    %x(screen -d -m ruby app/bot/dearqut.rb)
  end
  
  desc "Stop the DearQUT bot"
  task :stop do
    puts "Stopping the bot"
    pid = `cat tmp/pids/bot.pid 2>/dev/null`.chomp
    `kill #{pid} 2>/dev/null || echo 'Already stopped'` if $?.success?
  end
  
  desc "Restarts the DearQUT bot"
  task :restart => [:stop, :start]
end