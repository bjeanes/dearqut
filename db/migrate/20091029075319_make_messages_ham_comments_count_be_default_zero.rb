class MakeMessagesHamCommentsCountBeDefaultZero < ActiveRecord::Migration
  def self.up
    change_column :messages, :ham_comments_count, :integer, :default => 0, :null => false
    Message.update_ham_comments_count
  end

  def self.down
    change_column :messages, :ham_comments_count, :integer
  end
end
