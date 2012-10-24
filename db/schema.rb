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

ActiveRecord::Schema.define(:version => 20121022234620) do

  create_table "contas_dimension", :force => true do |t|
    t.string "conta"
    t.string "valor"
  end

  create_table "data_tables", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.boolean  "fact"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "data_tables", ["user_id"], :name => "index_data_tables_on_user_id"

  create_table "descricao_dimension", :force => true do |t|
    t.string "categoria"
    t.string "tipo"
  end

  create_table "fields", :force => true do |t|
    t.string   "db_type"
    t.string   "description"
    t.boolean  "is_null"
    t.integer  "data_table_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "fields", ["data_table_id"], :name => "index_fields_on_data_table_id"

  create_table "inbounds", :force => true do |t|
    t.binary   "file"
    t.integer  "raw_file_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "inbounds", ["raw_file_id"], :name => "index_inbounds_on_raw_file_id"

  create_table "raw_files", :force => true do |t|
    t.binary   "file"
    t.string   "template"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.integer  "user_id"
    t.string   "status"
    t.string   "filename",     :default => "", :null => false
    t.string   "content_type", :default => "", :null => false
    t.string   "header"
  end

  add_index "raw_files", ["user_id"], :name => "index_raw_files_on_user_id"

  create_table "reports", :force => true do |t|
    t.string   "description"
    t.text     "fields"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "reports", ["user_id"], :name => "index_reports_on_user_id"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "models"
  end

  add_index "roles", ["name"], :name => "index_roles_on_name", :unique => true

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  add_index "roles_users", ["role_id"], :name => "index_roles_users_on_role_id"
  add_index "roles_users", ["user_id"], :name => "index_roles_users_on_user_id"

  create_table "transacao_fact", :force => true do |t|
    t.string  "data"
    t.integer "contas_id"
    t.integer "descricao_id"
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
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "full_name"
    t.integer  "user_id"
    t.string   "status"
    t.string   "user"
    t.integer  "delete_flag"
    t.integer  "active_flag"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["user"], :name => "index_users_on_user", :unique => true

end
