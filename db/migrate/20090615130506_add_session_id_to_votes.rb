class AddSessionIdToVotes < ActiveRecord::Migration
  def self.up
    add_column :votes, :session_id, :string
    add_index  :votes, :session_id
    add_index  :votes, [:message_id, :session_id]
  end

  def self.down
    remove_column :votes, :session_id
  end
end
