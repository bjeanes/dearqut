class AddPasswordAuthenticationToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :crypted_password,          :string, :limit => 40
    add_column :users, :salt,                      :string, :limit => 40
          
    add_index :users, :login, :unique => true
  end

  def self.down
    remove_column :users, :crypted_password
    remove_column :users, :salt
    
    remove_index :users, :login
  end
end
