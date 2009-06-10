class AddCommentsCountToMessages < ActiveRecord::Migration
  def self.up
    add_column :messages, :comments_count, :integer
    add_index  :messages, :comments_count
  end

  def self.down
    remove_column :messages, :comments_count
  end
end
