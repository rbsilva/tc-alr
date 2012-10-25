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

ActiveRecord::Schema.define(:version => 20121024210341) do

  create_table "produtos_dimensions", :force => true do |t|
    t.integer  "qtd"
    t.string   "nome"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "teste2_dimensions", :force => true do |t|
    t.binary   "teste"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "teste_dimensions", :force => true do |t|
    t.text     "teste"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "teste_facts", :force => true do |t|
    t.integer  "teste_dimension_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "teste_facts", ["teste_dimension_id"], :name => "index_teste_facts_on_teste_dimension_id"

  create_table "vendas_facts", :force => true do |t|
    t.integer  "produtos_dimension_id"
    t.decimal  "valor"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  add_index "vendas_facts", ["produtos_dimension_id"], :name => "index_vendas_facts_on_produtos_dimension_id"

end
