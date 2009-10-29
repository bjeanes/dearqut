class ChangeUsersCryptedPasswordTo128Chars < ActiveRecord::Migration
  def self.up
    change_column :users, :crypted_password, :string, :limit => 128
    change_column :users, :password_salt, :string,    :limit => 128
  end

  def self.down
  end
end
