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

ActiveRecord::Schema.define(:version => 20121202170954) do

  create_table "categories", :force => true do |t|
    t.string   "code",          :limit => 64,  :null => false
    t.string   "name",          :limit => 256
    t.integer  "display_order"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "account_id"
  end

  create_table "cells", :force => true do |t|
    t.integer  "import_id"
    t.integer  "row"
    t.integer  "column"
    t.string   "cell_value"
    t.string   "field_name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "imports", :force => true do |t|
    t.integer "account_id"
    t.integer "user_id"
    t.string  "model"
    t.integer "first_row"
    t.integer "row_count"
  end

  create_table "item_specs", :force => true do |t|
    t.integer  "item_id"
    t.integer  "spec_id"
    t.integer  "version"
    t.date     "eff_date"
    t.string   "tag"
    t.integer  "test_id"
    t.string   "changed_by"
    t.decimal  "numeric_value"
    t.string   "string_value"
    t.text     "text_value"
    t.string   "document_title"
    t.string   "document_url"
    t.string   "document_version", :limit => 32
    t.decimal  "lsl"
    t.decimal  "usl"
    t.string   "unit_of_measure",  :limit => 64
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "deleted",                        :default => false
  end

  create_table "items", :force => true do |t|
    t.string   "code",       :limit => 64,  :null => false
    t.string   "name",       :limit => 128
    t.integer  "account_id",                :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "specs", :force => true do |t|
    t.string   "code",          :limit => 64,  :null => false
    t.string   "name",          :limit => 128
    t.integer  "usl"
    t.integer  "lsl"
    t.string   "label",         :limit => 64
    t.integer  "display_order"
    t.integer  "account_id",                   :null => false
    t.string   "created_by"
    t.string   "changed_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
  end

  create_table "tests", :force => true do |t|
    t.string   "code",         :limit => 64,  :null => false
    t.string   "name",         :limit => 128
    t.text     "instructions"
    t.integer  "account_id",                  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

end
