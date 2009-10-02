class AddLastCommentedAtToMessages < ActiveRecord::Migration
  def self.up
    add_column :messages, :last_commented_at, :datetime
    add_index :messages, :last_commented_at
  
    Message.connection.execute(
      %Q[UPDATE messages 
         SET last_commented_at =
           (SELECT created_at 
            FROM comments 
            WHERE message_id = messages.id 
            ORDER BY created_at DESC 
            LIMIT 1)])
  end

  def self.down
    remove_column :messages, :last_commented_at
  end
end
