class RenameUsersToTwitterUsers < ActiveRecord::Migration
  def self.up
    rename_table :users, :twitter_users
  end

  def self.down
    rename_table :twitter_users, :users
  end
end
