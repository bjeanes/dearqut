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

ActiveRecord::Schema.define(:version => 20091029023213) do

  create_table "activities", :force => true do |t|
    t.integer  "target_id"
    t.string   "target_type"
    t.integer  "user_id"
    t.string   "action"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["action"], :name => "index_activities_on_action"
  add_index "activities", ["created_at"], :name => "index_activities_on_created_at"
  add_index "activities", ["target_type"], :name => "index_activities_on_target_type"
  add_index "activities", ["user_id"], :name => "index_activities_on_user_id"

  create_table "bans", :force => true do |t|
    t.string   "ip",         :null => false
    t.string   "reason",     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bans", ["ip"], :name => "index_bans_on_ip"

  create_table "campus", :force => true do |t|
    t.string   "name"
    t.string   "abbreviation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "message_id",                     :null => false
    t.text     "body",                           :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ip"
    t.string   "spam_status"
    t.boolean  "private",     :default => false
  end

  add_index "comments", ["ip"], :name => "index_comments_on_ip"
  add_index "comments", ["message_id"], :name => "index_comments_on_message_id"
  add_index "comments", ["spam_status"], :name => "index_comments_on_spam_status"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "faculties", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "flags", :force => true do |t|
    t.integer  "message_id", :null => false
    t.integer  "ip"
    t.integer  "user_id"
    t.string   "reason"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "flags", ["message_id"], :name => "index_flags_on_message_id"

  create_table "messages", :force => true do |t|
    t.integer  "user_id"
    t.text     "body",                                                :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tweet_id",            :limit => 8
    t.boolean  "private"
    t.integer  "rating",                           :default => 0,     :null => false
    t.integer  "negative_vote_count",              :default => 0,     :null => false
    t.integer  "positive_vote_count",              :default => 0,     :null => false
    t.integer  "comments_count",                   :default => 0,     :null => false
    t.integer  "faculty_id"
    t.integer  "campus_id"
    t.datetime "last_commented_at"
    t.string   "ip"
    t.string   "moderation_status"
    t.integer  "ham_comments_count"
    t.boolean  "moderated",                        :default => false
  end

  add_index "messages", ["campus_id"], :name => "index_messages_on_campus_id"
  add_index "messages", ["comments_count"], :name => "index_messages_on_comments_count"
  add_index "messages", ["faculty_id"], :name => "index_messages_on_faculty_id"
  add_index "messages", ["ham_comments_count"], :name => "index_messages_on_ham_comments_count"
  add_index "messages", ["ip"], :name => "index_messages_on_ip"
  add_index "messages", ["last_commented_at"], :name => "index_messages_on_last_commented_at"
  add_index "messages", ["moderated"], :name => "index_messages_on_moderated"
  add_index "messages", ["moderation_status"], :name => "index_messages_on_spam_status"
  add_index "messages", ["negative_vote_count"], :name => "index_messages_on_negative_vote_count"
  add_index "messages", ["positive_vote_count"], :name => "index_messages_on_positive_vote_count"
  add_index "messages", ["rating"], :name => "index_messages_on_rating"
  add_index "messages", ["tweet_id"], :name => "index_messages_on_tweet_id", :unique => true
  add_index "messages", ["user_id"], :name => "index_messages_on_user_id"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "taggings", :force => true do |t|
    t.integer "tag_id"
    t.integer "taggable_id"
    t.string  "taggable_type"
    t.integer "user_id"
  end

  add_index "taggings", ["tag_id", "taggable_type"], :name => "index_taggings_on_tag_id_and_taggable_type"
  add_index "taggings", ["taggable_id", "taggable_type"], :name => "index_taggings_on_taggable_id_and_taggable_type"
  add_index "taggings", ["user_id", "tag_id", "taggable_type"], :name => "index_taggings_on_user_id_and_tag_id_and_taggable_type"
  add_index "taggings", ["user_id", "taggable_id", "taggable_type"], :name => "index_taggings_on_user_id_and_taggable_id_and_taggable_type"

  create_table "tags", :force => true do |t|
    t.string  "name"
    t.integer "taggings_count", :default => 0, :null => false
  end

  add_index "tags", ["name"], :name => "index_tags_on_name"
  add_index "tags", ["taggings_count"], :name => "index_tags_on_taggings_count"

  create_table "users", :force => true do |t|
    t.string   "twitter_id"
    t.string   "login"
    t.string   "oauth_token"
    t.string   "oauth_secret"
    t.string   "remember_token",            :limit => 40
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
    t.string   "crypted_password"
    t.string   "password_salt"
    t.boolean  "admin",                                   :default => false, :null => false
    t.string   "email"
    t.boolean  "staff",                                   :default => false, :null => false
    t.boolean  "staff_status_confirmed",                  :default => false, :null => false
    t.string   "persistence_token",                                          :null => false
    t.string   "single_access_token",                                        :null => false
    t.string   "perishable_token",                                           :null => false
    t.integer  "login_count",                             :default => 0,     :null => false
    t.integer  "failed_login_count",                      :default => 0,     :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["login"], :name => "index_users_on_login", :unique => true
  add_index "users", ["oauth_token"], :name => "index_users_on_oauth_token"
  add_index "users", ["staff"], :name => "index_users_on_staff"
  add_index "users", ["staff_status_confirmed"], :name => "index_users_on_staff_status_confirmed"

  create_table "votes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "message_id", :null => false
    t.integer  "value",      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "session_id"
    t.string   "ip"
    t.string   "user_agent"
  end

  add_index "votes", ["ip"], :name => "index_votes_on_ip"
  add_index "votes", ["message_id", "session_id"], :name => "index_votes_on_message_id_and_session_id"
  add_index "votes", ["message_id"], :name => "index_votes_on_message_id"
  add_index "votes", ["session_id"], :name => "index_votes_on_session_id"
  add_index "votes", ["user_agent"], :name => "index_votes_on_user_agent"
  add_index "votes", ["user_id", "message_id"], :name => "index_votes_on_user_id_and_message_id"
  add_index "votes", ["user_id"], :name => "index_votes_on_user_id"

end
