class AddIndexToRatingOnMessages < ActiveRecord::Migration
  def self.up
    add_index :messages, :rating
  end

  def self.down
    remove_index :messages, :rating
  end
end
