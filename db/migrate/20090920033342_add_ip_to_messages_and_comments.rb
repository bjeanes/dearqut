class AddIpToMessagesAndComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :ip, :string
    add_column :messages, :ip, :string
    
    add_index :comments, :ip
    add_index :messages, :ip
  end

  def self.down
    remove_column :comments, :ip
    remove_column :messages, :ip
  end
end
