class AddAuthlogicFieldsToUsers < ActiveRecord::Migration
  def self.up
    change_column :users, :login, :string, :null => false # optional, you can use email instead, or both
    rename_column :users, :salt, :password_salt
    
    add_column :users, :persistence_token,   :string, :null => false # required
    add_column :users, :single_access_token, :string, :null => false # optional, see Authlogic::Session::Params
    add_column :users, :perishable_token,    :string, :null => false # optional, see Authlogic::Session::Perishability
    
    # Magic columns, just like ActiveRecord's created_at and updated_at. These are automatically maintained by Authlogic if they are present.
    add_column :users, :login_count,        :integer,  :null => false, :default => 0 # optional, see Authlogic::Session::MagicColumns
    add_column :users, :failed_login_count, :integer,  :null => false, :default => 0 # optional, see Authlogic::Session::MagicColumns
    add_column :users, :last_request_at,    :datetime                                # optional, see Authlogic::Session::MagicColumns
    add_column :users, :current_login_at,   :datetime                                # optional, see Authlogic::Session::MagicColumns
    add_column :users, :last_login_at,      :datetime                                # optional, see Authlogic::Session::MagicColumns
    add_column :users, :current_login_ip,   :string                                  # optional, see Authlogic::Session::MagicColumns
    add_column :users, :last_login_ip,      :string                                  # optional, see Authlogic::Session::MagicColumns

    remove_index :users, :login
    add_index :users, :login, :unique => true
  end

  def self.down
  end
end