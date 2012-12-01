# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121201202433) do

  create_table "advertisements", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "advertises", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "invitations", :force => true do |t|
    t.integer  "sender_id"
    t.string   "recipient_email"
    t.string   "token"
    t.datetime "sent_at"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "messages", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "microposts", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.string   "song"
    t.string   "title"
    t.boolean  "available",  :default => false
    t.string   "artist"
    t.string   "genre"
    t.string   "hashtag"
    t.string   "sc_link"
  end

  add_index "microposts", ["user_id", "created_at"], :name => "index_microposts_on_user_id_and_created_at"

  create_table "private_messages", :force => true do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.boolean  "sender_deleted",    :default => false
    t.boolean  "recipient_deleted", :default => false
    t.string   "subject"
    t.text     "body"
    t.datetime "read_at"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
  end

  create_table "relationships", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "relationships", ["followed_id"], :name => "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], :name => "index_relationships_on_follower_id_and_followed_id", :unique => true
  add_index "relationships", ["follower_id"], :name => "index_relationships_on_follower_id"

  create_table "reposts", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.integer  "micropost_id", :limit => 255
    t.string   "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "reposts", ["created_at"], :name => "index_reposts_on_created_at"
  add_index "reposts", ["micropost_id"], :name => "index_reposts_on_micropost_id"

  create_table "retweetings", :force => true do |t|
    t.integer  "retweeter_id"
    t.integer  "retweet_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "retweetings", ["retweet_id"], :name => "index_retweetings_on_retweet_id"
  add_index "retweetings", ["retweeter_id", "retweet_id"], :name => "index_retweetings_on_retweeter_id_and_retweet_id", :unique => true
  add_index "retweetings", ["retweeter_id"], :name => "index_retweetings_on_retweeter_id"

  create_table "testimonies", :force => true do |t|
    t.string   "tweet_id"
    t.string   "screen_name"
    t.text     "content"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "post_id"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",                  :default => false
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.string   "image"
    t.string   "summary"
    t.string   "username"
    t.integer  "invitation_id"
    t.integer  "invitation_limit"
    t.string   "background_image"
    t.string   "slug"
    t.string   "soundcloud_link"
    t.string   "facebook_link"
    t.string   "twitter_link"
    t.string   "twitter_auth"
    t.string   "soundcloud_auth"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"
  add_index "users", ["slug"], :name => "index_users_on_slug"

end
