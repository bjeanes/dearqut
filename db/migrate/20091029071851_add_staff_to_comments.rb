class AddStaffToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :staff, :boolean, :default => false
    add_index :comments, :staff
  end

  def self.down
    remove_column :comments, :staff
  end
end
