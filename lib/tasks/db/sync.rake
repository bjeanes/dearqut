namespace :db do
  task :sync do
    ssh      = 'ssh dearqut@115.69.29.3'
    password = 'cat ~/app/config/database.yml | grep password | ruby -e "puts STDIN.read.split(/: /).last.chomp"'
    command  = "mysqldump dearqut -uroot -p`#{password}`"
    db       = 'mysql -uroot dearqut_development'
    
    run = "#{ssh} '#{command}' | #{db}"
    puts run
    system(run)
  end
end
