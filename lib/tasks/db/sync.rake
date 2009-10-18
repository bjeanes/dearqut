namespace :db do
  task :sync do
    ssh      = 'ssh deploy@dearqut.com'
    password = 'cat ~/app/config/database.yml | grep password | ruby -e "puts STDIN.read.split(/: /).last.chomp"'
    command  = "mysqldump dearqut -uroot -p`#{password}`"
    db       = 'mysql -uroot dearqut_development'
    
    run = "#{ssh} '#{command}' | #{db}"
    puts run
    system(run)
  end
end
