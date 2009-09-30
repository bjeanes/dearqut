class AddSpamStatusToMessagesAndComments < ActiveRecord::Migration
  def self.up
    add_column :messages, :spam_status, :string
    add_column :comments, :spam_status, :string
    add_index :messages, :spam_status
    add_index :comments, :spam_status
    
    $stdout.print "Checking existing content for spam: "
    (Message.all + Comment.all).each do |item|
      item.send :calculate_snook_score
      item.save(false)
      $stdout.print "."
      $stdout.flush
    end
    $stdout.print "\n"
  end

  def self.down
    remove_column :messages, :spam_status
    remove_column :comments, :spam_status
  end
end
