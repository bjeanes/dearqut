class AddUniqueIndexToMessages < ActiveRecord::Migration
  def self.up
    remove_index :messages, :tweet_id
    add_index :messages, :tweet_id, :unique => true
  end

  def self.down
    remove_index :messages, :tweet_id
    add_index :messages, :tweet_id
  end
end
