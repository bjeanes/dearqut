class MakeUserIdAllowNullOnVotes < ActiveRecord::Migration
  def self.up
    change_column :votes, :user_id, :integer, :null => true
  end

  def self.down
    change_column :votes, :user_id, :integer, :null => false
  end
end
