namespace :bot do
  desc "Start the DearQUT bot"
  task :start do
    %x{cd app/bot && RAILS_ENV=#{ENV['RAILS_ENV']||'development'} screen -d -m ruby dearqut.rb}
  end
  
  desc "Stop the DearQUT bot"
  task :stop do
     %x{kill `cat tmp/pids/bot.pid` || echo 'Already stopped'}
  end
  
  desc "Restarts the DearQUT bot"
  task :restart do
    stop
    start
  end
end