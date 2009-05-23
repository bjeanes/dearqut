class CreateVotes < ActiveRecord::Migration
  def self.up
    create_table :votes do |t|
      t.references :user,    :null => false
      t.references :message, :null => false
      t.integer    :value,         :null => false

      t.timestamps
    end
    
    add_index :votes, :user_id
    add_index :votes, :message_id
    add_index :votes, [:user_id, :message_id], :unique => true
  end

  def self.down
    drop_table :votes
  end
end
