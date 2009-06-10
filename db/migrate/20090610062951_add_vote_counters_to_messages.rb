class AddVoteCountersToMessages < ActiveRecord::Migration
  def self.up
    add_column :messages, :negative_vote_count, :integer
    add_column :messages, :positive_vote_count, :integer
    
    add_index :messages, :negative_vote_count
    add_index :messages, :positive_vote_count
    
    Message.all.each do |message|
      message.send :update_rating!
    end
  end

  def self.down
    remove_column :messages, :negative_vote_count
    remove_column :messages, :positive_vote_count
  end
end
