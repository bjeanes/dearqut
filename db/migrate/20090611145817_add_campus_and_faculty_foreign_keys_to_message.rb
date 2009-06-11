class AddCampusAndFacultyForeignKeysToMessage < ActiveRecord::Migration
  def self.up
    add_column :messages, :faculty_id, :integer
    add_column :messages, :campus_id, :integer
    
    add_index :messages, :faculty_id
    add_index :messages, :campus_id 
  end

  def self.down
    remove_column :messages, :campus_id
    remove_column :messages, :faculty_id
  end
end
