class CreateFlagReasons < ActiveRecord::Migration
  def self.up
    create_table :flag_reasons do |t|
      t.integer :message_id, :null => false
      t.integer :ip
      t.integer :user_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :flag_reasons
  end
end
