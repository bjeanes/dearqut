set :application,             "dearqut"
set :repository,              "git@github.com:bjeanes/#{application}.git"
set :domain,                  "115.69.29.3"
                              
set :user,                    application
                              
set :deploy_to,               "/srv/http/#{application}"
                              
set :scm, :git                
set :repository,              "git@github.com:bjeanes/#{application}.git"
set :branch,                  "master"
set :deploy_via,              :remote_cache
set :git_enable_submodules,   true

set :ssh_options,             { :forward_agent => true }
                              
set :use_sudo,                false
                              
role :app,                    domain
role :web,                    domain
role :db,                     domain, :primary => true
                              
set :rails_env,               "production"

before 'deploy:cold',         'deploy:upload_database_yml'
# before 'deploy',              'bot:stop'
after  'deploy',              'deploy:migrate'
# after  'deploy',              'bot:start'
after  'deploy:symlink',      'deploy:restart'
after  'deploy:symlink',      'deploy:create_symlinks'
after  'deploy:symlink',      'deploy:install_gems'
after  'deploy:symlink',      'deploy:update_crontab'

namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end
  
  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
  
  desc "Uploads database.yml file to shared path"
  task :upload_database_yml, :roles => :app do
    put(File.read('config/database.yml'), "#{shared_path}/database.yml", :mode => 0644)
  end
  
  
  desc "Symlinks database.yml file from shared folder"
  task :create_symlinks, :roles => :app do
    run "rm -f #{release_path}/config/database.yml"
    run "ln -s #{shared_path}/database.yml #{current_path}/config/database.yml"
  end
  
  desc "Update the crontab file"
  task :update_crontab, :roles => :app do
    run "cd #{release_path} && whenever --update-crontab #{application}"
  end
  
  desc "Install gems"
  task :install_gems, :roles => :app do
    run "cd #{release_path} && rake gems:install"
  end
end

namespace :bot do
  desc "Start the DearQUT bot"
  task :start do
    # run "cd #{current_path}/app/bot && RAILS_ENV=#{rails_env} screen -d -m ruby dearqut.rb"
  end
  
  desc "Stop the DearQUT bot"
  task :stop do
    run "kill `cat #{current_path}/tmp/pids/bot.pid` || echo 'Already stopped'"
  end
  
  desc "Restarts the DearQUT bot"
  task :restart do
    stop
    start
  end
end