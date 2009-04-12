# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090405104746) do

  create_table "comments", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "message_id", :null => false
    t.text     "body",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["message_id"], :name => "index_comments_on_message_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "messages", :force => true do |t|
    t.integer  "user_id",                       :null => false
    t.text     "body",                          :null => false
    t.boolean  "twitter",    :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["twitter"], :name => "index_messages_on_twitter"
  add_index "messages", ["user_id"], :name => "index_messages_on_user_id"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "access_token"
    t.string   "access_secret"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "name"
    t.string   "location"
    t.string   "description"
    t.string   "profile_image_url"
    t.string   "url"
    t.boolean  "protected"
    t.integer  "utc_offset"
    t.string   "time_zone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

  create_table "votes", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "message_id", :null => false
    t.boolean  "up",         :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["message_id"], :name => "index_votes_on_message_id"
  add_index "votes", ["user_id", "message_id"], :name => "index_votes_on_user_id_and_message_id", :unique => true
  add_index "votes", ["user_id"], :name => "index_votes_on_user_id"

end
