class TwitterAuthMigration < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :twitter_id
      t.string :login
      t.string :access_token
      t.string :access_secret

      t.string :remember_token, :limit => 40
      t.datetime :remember_token_expires_at

      # This information is automatically kept
      # in-sync at each login of the user. You
      # may remove any/all of these columns.
      t.string :name
      t.string :location
      t.string :description
      t.string :profile_image_url
      t.string :url
      t.boolean :protected

      # Probably don't need both, but they're here.
      t.integer :utc_offset
      t.string :time_zone

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
