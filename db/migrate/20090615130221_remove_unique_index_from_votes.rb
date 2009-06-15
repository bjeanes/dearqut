class RemoveUniqueIndexFromVotes < ActiveRecord::Migration
  def self.up
    remove_index :votes, [:user_id, :message_id]
    add_index    :votes, [:user_id, :message_id]
  end

  def self.down
    remove_index :votes, [:user_id, :message_id]
    add_index    :votes, [:user_id, :message_id], :unique => true
  end
end
