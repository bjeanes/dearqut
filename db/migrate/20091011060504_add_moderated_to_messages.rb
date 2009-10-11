class AddModeratedToMessages < ActiveRecord::Migration
  def self.up
    add_column :messages, :moderated, :boolean, :default => false
    add_index :messages, :moderated
  end

  def self.down
    remove_column :messages, :moderated
  end
end
