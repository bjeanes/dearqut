class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.references :user, :null => false
      t.text :body,       :null => false
      t.boolean :twitter, :null => false

      t.timestamps
    end
    
    add_index :messages, :user_id
    add_index :messages, :twitter
  end

  def self.down
    drop_table :messages
  end
end
