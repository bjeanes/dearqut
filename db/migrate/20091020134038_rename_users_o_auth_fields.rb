class RenameUsersOAuthFields < ActiveRecord::Migration
  def self.up
    rename_column :users, :access_token,  :oauth_token
    rename_column :users, :access_secret, :oauth_secret
    
    add_index :users, :oauth_token

    change_column :users, :login, :string, :default => nil, :null => true
    change_column :users, :crypted_password, :string, :default => nil, :null => true
    change_column :users, :password_salt, :string, :default => nil, :null => true
  end

  def self.down
    rename_column :users, :oauth_token,  :access_token
    rename_column :users, :oauth_secret, :access_secret

    [:login, :crypted_password, :password_salt].each do |field|
      User.all(:conditions => "#{field} is NULL").each { |user| user.update_attribute(field, "") if user.send(field).nil? }
      change_column :users, field, :string, :default => "", :null => false
    end
  end
end
