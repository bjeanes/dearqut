pid_file = File.join(RAILS_ROOT, 'tmp', 'pids', 'bot.pid')

File.open(pid_file, 'w') do |f|
  puts "PID: #{Process.pid}"
  f.write(Process.pid)
end

at_exit { File.unlink(pid_file) }