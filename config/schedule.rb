# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :cron_log, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

set :cron_log, File.join(RAILS_ROOT, 'log', 'cron.log')

every 15.minutes do
  # Ensure that the bot is running
  rake 'bot:start'
end

every 1.hour do
  runner "Message.update_last_commented_at; Message.update_ham_comments_count"
end