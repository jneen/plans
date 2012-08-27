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

ActiveRecord::Schema.define(:version => 20120827113526) do

  create_table "accounts", :force => true do |t|
    t.string   "login",                                  :null => false
    t.string   "salt"
    t.string   "crypted_password",                       :null => false
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.boolean  "temporary_password", :default => false
    t.string   "name"
    t.string   "theme_name"
    t.boolean  "hidden",             :default => false
    t.string   "password_type",      :default => "sha2"
  end

  add_index "accounts", ["login"], :name => "index_accounts_on_login", :unique => true

  create_table "plan_views", :force => true do |t|
    t.integer  "account_id"
    t.integer  "viewed_id"
    t.datetime "viewed_at"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "plan_views", ["account_id", "viewed_id"], :name => "index_auto_fingers_on_account_id_and_fingered_id", :unique => true

  create_table "planloves", :force => true do |t|
    t.integer  "plan_id"
    t.integer  "account_id"
    t.integer  "count"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "planloves", ["account_id"], :name => "index_planloves_on_account_id"
  add_index "planloves", ["plan_id", "account_id"], :name => "index_planloves_on_plan_id_and_account_id", :unique => true

  create_table "plans", :force => true do |t|
    t.text     "contents",   :default => "", :null => false
    t.text     "html",                       :null => false
    t.integer  "account_id",                 :null => false
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  add_index "plans", ["account_id"], :name => "index_plans_on_account_id", :unique => true

end
