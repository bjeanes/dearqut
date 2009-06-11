class AddAdminFieldToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :admin, :boolean, :null => false, :default => false
    
    %w{riblah bjeanes}.each do |u|
      if user = User.find_by_login(u)
        user.admin = true
        user.save
      end
    end
  end

  def self.down
    remove_column :users, :admin
  end
end
