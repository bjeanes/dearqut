class AddHamCommentsCountToMessages < ActiveRecord::Migration
  def self.up
    add_column :messages, :ham_comments_count, :integer
    add_index :messages, :ham_comments_count
    
    Message.all.each do |message|
      message.ham_comments_count ||= message.comments.ham.size
      message.save(false)
    end
  end

  def self.down
    remove_column :messages, :ham_comments_count
  end
end
