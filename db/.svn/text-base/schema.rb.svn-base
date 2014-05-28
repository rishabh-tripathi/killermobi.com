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

ActiveRecord::Schema.define(:version => 20120422104721) do

  create_table "activities", :force => true do |t|
    t.integer  "user_id",        :default => 0, :null => false
    t.integer  "obj_type",       :default => 0, :null => false
    t.integer  "obj_id",         :default => 0, :null => false
    t.integer  "activity_type",  :default => 0, :null => false
    t.integer  "activity_scope", :default => 0, :null => false
    t.text     "activity_text",                 :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "articles", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "synopsis"
    t.text     "body"
    t.boolean  "published",       :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "published_at"
    t.integer  "category_id",     :default => 1
    t.text     "seo_keyword"
    t.text     "seo_description"
    t.text     "page_title"
    t.string   "cached_tag_list"
  end

  create_table "auth_apps", :force => true do |t|
    t.string  "app_id",   :default => "", :null => false
    t.string  "app_key",  :default => "", :null => false
    t.integer "user_id",  :default => 0,  :null => false
    t.integer "varified", :default => 0,  :null => false
    t.integer "trashed",  :default => 0,  :null => false
  end

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "access_token", :limit => 1024, :default => "", :null => false
  end

  create_table "beta_comments", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "review"
    t.string   "app"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bucket_items", :force => true do |t|
    t.integer  "bucket_id",  :default => 0, :null => false
    t.integer  "obj_type",   :default => 0, :null => false
    t.integer  "obj_id",     :default => 0, :null => false
    t.integer  "status",     :default => 0, :null => false
    t.integer  "access",     :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "buckets", :force => true do |t|
    t.string   "name",           :limit => 100,  :default => "",  :null => false
    t.string   "detail",         :limit => 1024, :default => "",  :null => false
    t.integer  "user_id",                        :default => 0,   :null => false
    t.integer  "status",                         :default => 0,   :null => false
    t.integer  "access",                         :default => 0,   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "zip_path",       :limit => 1000, :default => "",  :null => false
    t.string   "zip_name",                       :default => "",  :null => false
    t.string   "download_id",                    :default => "0", :null => false
    t.integer  "download_count",                 :default => 0,   :null => false
  end

  create_table "categories", :force => true do |t|
    t.string "name"
  end

  create_table "comments", :force => true do |t|
    t.integer  "entry_id"
    t.integer  "user_id"
    t.string   "guest_name"
    t.string   "guest_email"
    t.string   "guest_url"
    t.text     "body"
    t.datetime "created_at"
  end

  add_index "comments", ["entry_id"], :name => "index_comments_on_entry_id"

  create_table "devices", :force => true do |t|
    t.string   "vendor"
    t.string   "model"
    t.string   "os"
    t.string   "java_cldc"
    t.string   "java_midp"
    t.string   "img"
    t.string   "price"
    t.text     "feature"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "download_categories", :force => true do |t|
    t.string "category"
    t.text   "seo_keyword"
    t.text   "seo_description"
    t.string "url"
    t.text   "page_title"
  end

  create_table "download_comments", :force => true do |t|
    t.integer  "download_id"
    t.integer  "user_id"
    t.string   "guest_name"
    t.string   "guest_email"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "download_types", :force => true do |t|
    t.string "platform"
    t.string "url"
    t.text   "seo_keyword"
    t.text   "seo_description"
  end

  create_table "downloads", :force => true do |t|
    t.string   "title"
    t.string   "short_description"
    t.text     "description"
    t.string   "powered_by"
    t.integer  "downloads"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file1url"
    t.string   "file2url"
    t.string   "ss1url"
    t.string   "ss2url"
    t.string   "ss3url"
    t.string   "comurl"
    t.text     "how_to_use"
    t.text     "compatible_devices"
    t.integer  "category_id"
    t.integer  "type_id"
    t.text     "seo_keyword"
    t.text     "seo_description"
    t.text     "page_title"
    t.integer  "recommanded"
    t.string   "liveclasspath"
    t.integer  "download_count"
    t.integer  "played_count"
    t.integer  "download_ext1"
    t.string   "cached_tag_list"
    t.string   "ss1_medium"
    t.string   "ss1_small"
    t.string   "ss1_thumb"
    t.integer  "day_count",          :default => 0,  :null => false
    t.integer  "week_count",         :default => 0,  :null => false
    t.integer  "month_count",        :default => 0,  :null => false
    t.text     "users_ids",                          :null => false
    t.string   "ss4url",             :default => "", :null => false
    t.string   "ss5url",             :default => "", :null => false
    t.string   "ss6url",             :default => "", :null => false
    t.text     "more_ss",                            :null => false
    t.string   "logo_url",           :default => "", :null => false
    t.text     "more_files",                         :null => false
    t.integer  "version",            :default => 0,  :null => false
    t.integer  "base_app_id",        :default => 0,  :null => false
    t.string   "sub_category",       :default => "", :null => false
    t.integer  "type",               :default => 0,  :null => false
    t.integer  "status",             :default => 0,  :null => false
    t.integer  "source",             :default => 0,  :null => false
    t.integer  "user_id",            :default => 0,  :null => false
  end

  create_table "entries", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "body"
    t.integer  "comments_count", :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "entries", ["user_id"], :name => "index_entries_on_user_id"

  create_table "external_channels", :force => true do |t|
    t.string   "channel"
    t.integer  "download_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "forums", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "topics_count",    :default => 0, :null => false
    t.text     "seo_keyword"
    t.text     "seo_description"
    t.text     "page_title"
  end

  create_table "friendships", :force => true do |t|
    t.integer  "user_id",     :default => 0, :null => false
    t.integer  "friend_id",   :default => 0, :null => false
    t.integer  "status",      :default => 0, :null => false
    t.integer  "type",        :default => 0, :null => false
    t.integer  "type_id",     :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "accepted_at"
    t.datetime "updated_at"
  end

  create_table "gj_apps", :id => false, :force => true do |t|
    t.text   "name"
    t.text   "short_disc"
    t.text   "app_type"
    t.text   "gj_url"
    t.text   "img_url"
    t.text   "app_cat"
    t.text   "full_disc"
    t.text   "compatible_device", :limit => 2147483647
    t.text   "download_url"
    t.string "file_name",         :limit => 200
    t.string "status",            :limit => 3,          :default => "0"
  end

  create_table "ideas", :force => true do |t|
    t.string   "title"
    t.string   "short_description"
    t.string   "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "published_at"
    t.boolean  "accepted"
    t.integer  "category_id"
    t.string   "documents"
    t.datetime "updated_at"
  end

  create_table "images", :force => true do |t|
    t.string   "name",         :limit => 100, :default => "", :null => false
    t.string   "image_base",   :limit => 100, :default => "", :null => false
    t.string   "image_medium", :limit => 100, :default => "", :null => false
    t.string   "image_small",  :limit => 100, :default => "", :null => false
    t.string   "image_thumb",  :limit => 100, :default => "", :null => false
    t.integer  "obj_type",                    :default => 0,  :null => false
    t.integer  "obj_id",                      :default => 0,  :null => false
    t.integer  "status",                      :default => 0,  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mnl_missing_codes", :force => true do |t|
    t.string   "code"
    t.string   "detail"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mnl_onlines", :force => true do |t|
    t.string   "code"
    t.string   "detail"
    t.integer  "mode"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "msg_categories", :force => true do |t|
    t.string   "category"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "msgs", :force => true do |t|
    t.text     "message"
    t.integer  "category_id"
    t.integer  "rating"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.integer  "topic_id"
    t.integer  "user_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "cached_tag_list"
  end

  add_index "posts", ["topic_id"], :name => "index_posts_on_topic_id"

  create_table "products", :force => true do |t|
    t.string   "name"
    t.string   "s_description"
    t.text     "description"
    t.string   "file_path"
    t.string   "ss1_path"
    t.string   "ss2_path"
    t.string   "ss3_path"
    t.string   "ss4_path"
    t.integer  "version"
    t.string   "downloads"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "permalink"
  end

  create_table "real_devices", :force => true do |t|
    t.string   "name",                                  :default => "",  :null => false
    t.integer  "user_id",                               :default => 0,   :null => false
    t.integer  "virtual_device",                        :default => 0,   :null => false
    t.string   "vendor",                                :default => "",  :null => false
    t.string   "model",                                 :default => "",  :null => false
    t.string   "operator",                              :default => "",  :null => false
    t.string   "IMEI",                                  :default => "",  :null => false
    t.string   "number",                                :default => "",  :null => false
    t.integer  "battery_status",                        :default => 0,   :null => false
    t.integer  "charging_status",                       :default => 0,   :null => false
    t.integer  "network_status",                        :default => 0,   :null => false
    t.integer  "bluetooth_status",                      :default => 0,   :null => false
    t.integer  "profile_status",                        :default => 0,   :null => false
    t.integer  "camera_status",                         :default => 0,   :null => false
    t.integer  "call_status",                           :default => 0,   :null => false
    t.integer  "message_status",                        :default => 0,   :null => false
    t.integer  "wifi_status",                           :default => 0,   :null => false
    t.string   "location_lat",                          :default => "0", :null => false
    t.string   "location_lang",                         :default => "0", :null => false
    t.integer  "have_bluetooth",                        :default => 0,   :null => false
    t.integer  "have_wifi",                             :default => 0,   :null => false
    t.integer  "have_camera",                           :default => 0,   :null => false
    t.integer  "have_sd_card",                          :default => 0,   :null => false
    t.integer  "operating_system",                      :default => 0,   :null => false
    t.text     "images",                                                 :null => false
    t.text     "contacts",                                               :null => false
    t.text     "videos",                                                 :null => false
    t.text     "apps",                                                   :null => false
    t.text     "files",                                                  :null => false
    t.text     "music_files",                                            :null => false
    t.text     "trash_files",                                            :null => false
    t.text     "call_log",                                               :null => false
    t.text     "calender",                                               :null => false
    t.text     "to_dos",                                                 :null => false
    t.text     "notes",                                                  :null => false
    t.text     "messages",                                               :null => false
    t.text     "notification",                                           :null => false
    t.text     "command",                                                :null => false
    t.integer  "sync_id",                               :default => 0,   :null => false
    t.text     "sync_token",                                             :null => false
    t.datetime "sync_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "authentication_tokens", :limit => 2000, :default => "",  :null => false
    t.string   "logged_in_via",         :limit => 2000, :default => "",  :null => false
    t.string   "access_token",                          :default => "",  :null => false
  end

  create_table "reviews", :force => true do |t|
    t.integer  "obj_type",                   :default => 0,  :null => false
    t.integer  "obj_id",                     :default => 0,  :null => false
    t.string   "title",      :limit => 100,  :default => "", :null => false
    t.string   "review",     :limit => 1024, :default => "", :null => false
    t.integer  "user_id",                    :default => 0,  :null => false
    t.integer  "rating",                     :default => 0,  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string "name"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id", :null => false
    t.integer "user_id", :null => false
  end

  create_table "spam_ids", :force => true do |t|
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type"], :name => "index_taggings_on_taggable_id_and_taggable_type"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "topics", :force => true do |t|
    t.integer  "forum_id"
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "posts_count",     :default => 0, :null => false
    t.text     "seo_keyword"
    t.text     "seo_description"
    t.text     "page_title"
  end

  add_index "topics", ["forum_id"], :name => "index_topics_on_forum_id"

  create_table "uploaded_files", :force => true do |t|
    t.string   "file_name",                   :default => "", :null => false
    t.string   "file_path",   :limit => 1024, :default => "", :null => false
    t.string   "file_size",   :limit => 100,  :default => "", :null => false
    t.integer  "storage",                     :default => 0,  :null => false
    t.integer  "file_type",                   :default => 0,  :null => false
    t.integer  "file_cat",                    :default => 0,  :null => false
    t.integer  "user_id",                     :default => 0,  :null => false
    t.integer  "access",                      :default => 0,  :null => false
    t.integer  "is_dir",                      :default => 0,  :null => false
    t.string   "thumb_image", :limit => 1024, :default => "", :null => false
    t.integer  "deleted",                     :default => 0,  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_apps", :force => true do |t|
    t.integer  "user_id",        :default => 0,  :null => false
    t.integer  "device_id",      :default => 0,  :null => false
    t.integer  "real_device_id", :default => 0,  :null => false
    t.integer  "app_id",         :default => 0,  :null => false
    t.integer  "source",         :default => 0,  :null => false
    t.string   "url",            :default => "", :null => false
    t.integer  "category",       :default => 0,  :null => false
    t.integer  "subcategory",    :default => 0,  :null => false
    t.string   "display_image",  :default => "", :null => false
    t.integer  "share_status",   :default => 0,  :null => false
    t.integer  "trashed",        :default => 0,  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_call_logs", :force => true do |t|
    t.integer  "user_id",        :default => 0,  :null => false
    t.integer  "device_id",      :default => 0,  :null => false
    t.integer  "real_device_id", :default => 0,  :null => false
    t.integer  "call_type",      :default => 0,  :null => false
    t.integer  "is_unknown",     :default => 0,  :null => false
    t.string   "from",           :default => "", :null => false
    t.integer  "trashed",        :default => 0,  :null => false
    t.datetime "received_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_contacts", :force => true do |t|
    t.integer  "user_id",        :default => 0,  :null => false
    t.integer  "device_id",      :default => 0,  :null => false
    t.integer  "real_device_id", :default => 0,  :null => false
    t.string   "name",           :default => "", :null => false
    t.string   "number",         :default => "", :null => false
    t.string   "location",       :default => "", :null => false
    t.integer  "category",       :default => 0,  :null => false
    t.integer  "subcategory",    :default => 0,  :null => false
    t.integer  "source",         :default => 0,  :null => false
    t.string   "contact_image",  :default => "", :null => false
    t.integer  "share_status",   :default => 0,  :null => false
    t.integer  "trashed",        :default => 0,  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_details", :force => true do |t|
    t.integer  "user_id",              :default => 0,  :null => false
    t.string   "profile_pic",          :default => "", :null => false
    t.string   "profile_pic_original", :default => "", :null => false
    t.text     "about_me",                             :null => false
    t.string   "fb_profile",           :default => "", :null => false
    t.string   "twitter_profile",      :default => "", :null => false
    t.string   "google_profile",       :default => "", :null => false
    t.string   "blog_url",             :default => "", :null => false
    t.string   "more_blog",            :default => "", :null => false
    t.text     "upld_apps_ids",                        :null => false
    t.text     "dwld_apps_ids",                        :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "mobimates",                            :null => false
    t.integer  "virtual_device",       :default => 0,  :null => false
  end

  create_table "user_images", :force => true do |t|
    t.integer  "user_id",        :default => 0,  :null => false
    t.integer  "device_id",      :default => 0,  :null => false
    t.integer  "real_device_id", :default => 0,  :null => false
    t.integer  "source",         :default => 0,  :null => false
    t.string   "url",            :default => "", :null => false
    t.integer  "category",       :default => 0,  :null => false
    t.integer  "subcategory",    :default => 0,  :null => false
    t.integer  "album_id",       :default => 0,  :null => false
    t.string   "display_image",  :default => "", :null => false
    t.integer  "share_status",   :default => 0,  :null => false
    t.integer  "trashed",        :default => 0,  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_messages", :force => true do |t|
    t.integer  "user_id",                        :default => 0,  :null => false
    t.integer  "device_id",                      :default => 0,  :null => false
    t.integer  "real_device_id",                 :default => 0,  :null => false
    t.integer  "message_type",                   :default => 0,  :null => false
    t.integer  "category",                       :default => 0,  :null => false
    t.integer  "subcategory",                    :default => 0,  :null => false
    t.string   "to",                             :default => "", :null => false
    t.string   "from",                           :default => "", :null => false
    t.string   "body",           :limit => 5000, :default => "", :null => false
    t.string   "attachment",     :limit => 1000, :default => "", :null => false
    t.integer  "source",                         :default => 0,  :null => false
    t.integer  "share_status",                   :default => 0,  :null => false
    t.integer  "trashed",                        :default => 0,  :null => false
    t.datetime "received_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_musics", :force => true do |t|
    t.integer  "user_id",        :default => 0,  :null => false
    t.integer  "device_id",      :default => 0,  :null => false
    t.integer  "real_device_id", :default => 0,  :null => false
    t.integer  "source",         :default => 0,  :null => false
    t.string   "url",            :default => "", :null => false
    t.integer  "category",       :default => 0,  :null => false
    t.integer  "subcategory",    :default => 0,  :null => false
    t.integer  "playlist_id",    :default => 0,  :null => false
    t.string   "display_image",  :default => "", :null => false
    t.integer  "share_status",   :default => 0,  :null => false
    t.integer  "trashed",        :default => 0,  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_notes", :force => true do |t|
    t.integer  "user_id",                        :default => 0,  :null => false
    t.integer  "device_id",                      :default => 0,  :null => false
    t.integer  "real_device_id",                 :default => 0,  :null => false
    t.string   "title",                          :default => "", :null => false
    t.string   "body",           :limit => 5000, :default => "", :null => false
    t.integer  "source",                         :default => 0,  :null => false
    t.string   "url",                            :default => "", :null => false
    t.integer  "category",                       :default => 0,  :null => false
    t.integer  "subcategory",                    :default => 0,  :null => false
    t.integer  "share_status",                   :default => 0,  :null => false
    t.integer  "trashed",                        :default => 0,  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_trashes", :force => true do |t|
    t.integer  "obj_id",     :default => 0, :null => false
    t.integer  "obj_type",   :default => 0, :null => false
    t.integer  "user_id",    :default => 0, :null => false
    t.integer  "device_id",  :default => 0, :null => false
    t.integer  "source",     :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_videos", :force => true do |t|
    t.integer  "user_id",        :default => 0,  :null => false
    t.integer  "device_id",      :default => 0,  :null => false
    t.integer  "real_device_id", :default => 0,  :null => false
    t.integer  "source",         :default => 0,  :null => false
    t.string   "url",            :default => "", :null => false
    t.integer  "category",       :default => 0,  :null => false
    t.integer  "subcategory",    :default => 0,  :null => false
    t.integer  "playlist_id",    :default => 0,  :null => false
    t.string   "display_image",  :default => "", :null => false
    t.integer  "share_status",   :default => 0,  :null => false
    t.integer  "trashed",        :default => 0,  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username",               :limit => 64,  :default => ""
    t.string   "email",                                 :default => "",   :null => false
    t.string   "old_hashed_password",    :limit => 64
    t.string   "firstname",              :limit => 30
    t.string   "lastname",               :limit => 30
    t.string   "handset",                :limit => 15
    t.string   "country",                :limit => 20
    t.string   "mobile",                 :limit => 15
    t.boolean  "enabled",                               :default => true, :null => false
    t.text     "profile"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "last_login_at"
    t.integer  "posts_count",                           :default => 0,    :null => false
    t.integer  "entries_count",                         :default => 0,    :null => false
    t.boolean  "enable_comments",                       :default => true
    t.integer  "facebook_id",            :limit => 8
    t.text     "last_activity",                                           :null => false
    t.datetime "last_activity_at"
    t.integer  "friends_count",                         :default => 0,    :null => false
    t.integer  "mobimate_count",                        :default => 0,    :null => false
    t.text     "mobimates",                                               :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "",   :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "password_salt"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "failed_attempts",                       :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
    t.integer  "current_bucket",                        :default => 0,    :null => false
  end

  create_table "virtual_devices", :force => true do |t|
    t.string   "name",         :default => "", :null => false
    t.integer  "user_id",      :default => 0,  :null => false
    t.string   "real_devices", :default => "", :null => false
    t.text     "contacts",                     :null => false
    t.text     "collections",                  :null => false
    t.text     "videos",                       :null => false
    t.text     "apps",                         :null => false
    t.text     "images",                       :null => false
    t.text     "trash_files",                  :null => false
    t.text     "music_files",                  :null => false
    t.text     "files",                        :null => false
    t.text     "call_log",                     :null => false
    t.text     "calender",                     :null => false
    t.text     "to_dos",                       :null => false
    t.text     "notes",                        :null => false
    t.text     "messages",                     :null => false
    t.integer  "theam_id",     :default => 0,  :null => false
    t.text     "notification",                 :null => false
    t.text     "command",                      :null => false
    t.datetime "sync_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wallpapers", :force => true do |t|
    t.string   "title",           :default => "", :null => false
    t.integer  "user_id",         :default => 0,  :null => false
    t.integer  "source",          :default => 0,  :null => false
    t.text     "description",                     :null => false
    t.string   "category",        :default => "", :null => false
    t.string   "sub_category",    :default => "", :null => false
    t.string   "url_original",    :default => "", :null => false
    t.string   "url_medium",      :default => "", :null => false
    t.string   "url_small",       :default => "", :null => false
    t.string   "url_thumb",       :default => "", :null => false
    t.string   "cached_tag_list", :default => "", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "worldcup2011s", :force => true do |t|
    t.string   "name"
    t.string   "on"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
