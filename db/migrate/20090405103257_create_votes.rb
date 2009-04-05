class CreateVotes < ActiveRecord::Migration
  def self.up
    create_table :votes do |t|
      t.references :user
      t.references :message
      t.boolean :up

      t.timestamps
    end
  end

  def self.down
    drop_table :votes
  end
end
