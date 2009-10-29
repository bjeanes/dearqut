class CreateFlags < ActiveRecord::Migration
  def self.up
    create_table :flags do |t|
      t.integer :message_id, :null => false
      t.integer :ip
      t.integer :user_id
      t.string :reason
      
      t.timestamps
    end
    
    add_index :flags, :message_id
  end

  def self.down
    drop_table :flags
  end
end
