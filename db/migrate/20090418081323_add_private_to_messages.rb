class AddPrivateToMessages < ActiveRecord::Migration
  def self.up
    add_column :messages, :private, :boolean
  end

  def self.down
    remove_column :messages, :private
  end
end
