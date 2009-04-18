class ChangeTweetBooleanFieldForTweetIdFieldOnMessages < ActiveRecord::Migration
  def self.up
    remove_column :messages, :twitter
    add_column    :messages, :tweet_id, :integer
    add_index     :messages, :tweet_id
  end

  def self.down
    add_column    :messages, :twitter, :boolean
    Message.update_all({:twitter => true}, "tweet_id IS NOT NULL")
    remove_column :messages, :tweet_id
  end
end
