class MakeCommentsCountDefaultToZero < ActiveRecord::Migration
  def self.up
    change_column :messages, :comments_count, :integer, :default => 0, :null => false
  end

  def self.down
    change_column :messages, :comments_count, :integer
  end
end
