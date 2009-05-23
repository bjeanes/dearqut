namespace :bot do
  desc "Start the DearQUT bot"
  task :start do
    %x{RAILS_ENV=#{ENV['RAILS_ENV']||'development'} screen -d -m ruby app/bot/dearqut.rb}
  end
  
  desc "Stop the DearQUT bot"
  task :stop do
     %x{kill `cat tmp/pids/bot.pid` || echo 'Already stopped'}
  end
  
  desc "Restarts the DearQUT bot"
  task :restart => [:stop, :start]
end