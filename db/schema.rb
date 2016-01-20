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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160109234859) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "archetypes", force: :cascade do |t|
    t.string   "name"
    t.string   "setting_symbol"
    t.string   "setting_symbol_example1"
    t.string   "setting_symbol_example2"
    t.string   "setting_symbol_example3"
    t.string   "setting_other"
    t.string   "setting_other_example1"
    t.string   "setting_other_example2"
    t.string   "setting_other_example3"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "characters", force: :cascade do |t|
    t.string   "name"
    t.integer  "archetype_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "def_looks", force: :cascade do |t|
    t.string   "look"
    t.integer  "archetype_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "def_tools", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "example_tools", force: :cascade do |t|
    t.string   "example"
    t.integer  "def_tool_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "looks", force: :cascade do |t|
    t.integer "character_id"
    t.integer "def_look_id"
  end

  create_table "name_categories", force: :cascade do |t|
    t.string   "name"
    t.integer  "archetype_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "relationships", force: :cascade do |t|
    t.string   "name"
    t.integer  "trust"
    t.integer  "trust_question_id"
    t.integer  "character_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "sample_names", force: :cascade do |t|
    t.string   "name"
    t.integer  "archetype_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "tools", force: :cascade do |t|
    t.integer "character_id"
    t.integer "def_tool_id"
    t.string  "name"
    t.text    "description"
  end

  create_table "trust_questions", force: :cascade do |t|
    t.string   "question"
    t.integer  "trust"
    t.integer  "archetype_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

end
