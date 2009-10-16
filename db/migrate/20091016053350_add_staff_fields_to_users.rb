class AddStaffFieldsToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :staff, :boolean, :default => false, :null => false
    add_column :users, :staff_status_confirmed, :boolean, :default => false, :null => false
    
    add_index :users, :staff
    add_index :users, :staff_status_confirmed
  end

  def self.down
    remove_column :users, :staff_status_confirmed
    remove_column :users, :staff
  end
end
