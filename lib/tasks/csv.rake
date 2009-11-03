task :csv => :environment do
  require 'fastercsv'
  i, j = 0, 0
  
  FileUtils.rm_rf("messages.csv")
  FileUtils.rm_rf("comments.csv")
  
  FasterCSV.open("messages.csv", "w") do |messages|
    FasterCSV.open("comments.csv", "w") do |comments|
      Message.ham.each do |message|
        messages << [i+=1, message.author, message.body, 1]
        message.comments.ham.each do |comment|
          comments << [j+=1, comment.author, comment.body, i]
        end
      end
    end
  end
end