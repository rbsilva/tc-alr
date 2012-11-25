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

ActiveRecord::Schema.define(:version => 20121125012656) do

  create_table "produtos_dimensions", :force => true do |t|
    t.string   "nome"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "vendas2_facts", :force => true do |t|
    t.decimal  "valor"
    t.integer  "produtos_dimension_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  add_index "vendas2_facts", ["produtos_dimension_id"], :name => "index_vendas2_facts_on_produtos_dimension_id"

  create_table "vendas3_facts", :force => true do |t|
    t.integer  "valor"
    t.integer  "produtos_dimension_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  add_index "vendas3_facts", ["produtos_dimension_id"], :name => "index_vendas3_facts_on_produtos_dimension_id"

  create_table "vendas_facts", :force => true do |t|
    t.integer  "valor"
    t.integer  "produtos_dimension_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  add_index "vendas_facts", ["produtos_dimension_id"], :name => "index_vendas_facts_on_produtos_dimension_id"

end
