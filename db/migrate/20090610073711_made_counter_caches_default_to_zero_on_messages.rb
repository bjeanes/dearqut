class MadeCounterCachesDefaultToZeroOnMessages < ActiveRecord::Migration
  def self.up
    [:rating, :negative_vote_count, :positive_vote_count].each do |col|
      change_column :messages, col, :integer, :default => 0, :null => false
    end
  end

  def self.down
    [:rating, :negative_vote_count, :positive_vote_count].each do |col|
      change_column :messages, col, :integer
    end
  end
end
