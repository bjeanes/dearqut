class IncreaseTweetIdIntSizeOnMessages < ActiveRecord::Migration
  def self.up
    change_column :messages, :tweet_id, :integer, :size => 8
  end

  def self.down
    change_column :messages, :tweet_id, :integer
  end
end
