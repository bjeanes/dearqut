class AddIpAndUserAgentToVotes < ActiveRecord::Migration
  def self.up
    add_column :votes, :ip, :string
    add_column :votes, :user_agent, :string
    
    add_index  :votes, :ip
    add_index  :votes, :user_agent
  end

  def self.down
    remove_column :votes, :user_agent
    remove_column :votes, :ip
  end
end
