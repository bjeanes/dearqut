class MakeMessagesUserIdOptional < ActiveRecord::Migration
  def self.up
    change_column :messages, :user_id, :integer, :null => true
  end

  def self.down
    change_column :messages, :user_id, :integer, :null => false
  end
end
