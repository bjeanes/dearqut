class AddRatingToMessages < ActiveRecord::Migration
  def self.up
    add_column :messages, :rating, :integer
  end

  def self.down
    remove_column :messages, :rating
  end
end
