class CreateBans < ActiveRecord::Migration
  def self.up
    create_table :bans do |t|
      t.string :ip,     :null => false
      t.string :reason, :null => false

      t.timestamps
    end
    
    add_index :bans, :ip
  end

  def self.down
    drop_table :bans
  end
end
