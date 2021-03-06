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

ActiveRecord::Schema.define(version: 20160218212324) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "archetypes", force: :cascade do |t|
    t.string  "name"
    t.string  "setting_symbol"
    t.string  "setting_symbol_example1"
    t.string  "setting_symbol_example2"
    t.string  "setting_symbol_example3"
    t.string  "setting_other"
    t.string  "setting_other_example1"
    t.string  "setting_other_example2"
    t.string  "setting_other_example3"
    t.integer "starting_move_count"
    t.integer "brave"
    t.integer "fierce"
    t.integer "wary"
    t.integer "clever"
    t.integer "strange"
  end

  create_table "characters", force: :cascade do |t|
    t.string   "name"
    t.integer  "archetype_id"
    t.boolean  "setting",          default: false
    t.integer  "starting_brave"
    t.integer  "starting_fierce"
    t.integer  "starting_wary"
    t.integer  "starting_clever"
    t.integer  "starting_strange"
    t.integer  "spirit"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "def_dire_fates", force: :cascade do |t|
    t.string  "text"
    t.integer "peril"
    t.integer "archetype_id"
    t.integer "order"
  end

  create_table "def_fates", force: :cascade do |t|
    t.integer "archetype_id"
    t.string  "name"
    t.text    "description"
    t.string  "advance"
    t.string  "complete"
  end

  create_table "def_improvements", force: :cascade do |t|
    t.integer "archetype_id"
    t.string  "action"
    t.string  "value"
    t.integer "order"
  end

  create_table "def_looks", force: :cascade do |t|
    t.string  "look"
    t.integer "archetype_id"
  end

  create_table "def_move_fields", force: :cascade do |t|
    t.integer "def_move_id"
    t.string  "name"
    t.boolean "creatable",   default: false
  end

  create_table "def_move_options", force: :cascade do |t|
    t.integer "def_move_id"
    t.string  "option"
  end

  create_table "def_moves", force: :cascade do |t|
    t.string  "name"
    t.integer "archetype_id"
    t.string  "stat"
    t.text    "body"
    t.boolean "has_description",    default: false
    t.boolean "free",               default: false
    t.integer "options_selectable"
  end

  create_table "def_tools", force: :cascade do |t|
    t.string "name"
  end

  create_table "def_vows", force: :cascade do |t|
    t.string "name"
    t.string "text"
  end

  create_table "dire_fates", force: :cascade do |t|
    t.integer  "character_id"
    t.integer  "def_dire_fate_id"
    t.boolean  "checked",          default: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "example_tools", force: :cascade do |t|
    t.string  "example"
    t.integer "def_tool_id"
  end

  create_table "fates", force: :cascade do |t|
    t.integer  "character_id"
    t.integer  "def_fate_id"
    t.integer  "advancement"
    t.boolean  "completed",    default: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "gift_curses", force: :cascade do |t|
    t.string "name"
  end

  create_table "gift_types", force: :cascade do |t|
    t.string "name"
  end

  create_table "gifts", force: :cascade do |t|
    t.integer  "character_id"
    t.integer  "gift_type_id"
    t.integer  "gift_curse_id"
    t.string   "name"
    t.text     "description"
    t.string   "detail"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "improvement_id"
  end

  create_table "improvements", force: :cascade do |t|
    t.integer  "character_id"
    t.integer  "def_improvement_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "looks", force: :cascade do |t|
    t.integer  "character_id"
    t.integer  "def_look_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "move_fields", force: :cascade do |t|
    t.integer  "move_id"
    t.integer  "def_move_field_id"
    t.string   "text"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "move_options", force: :cascade do |t|
    t.integer  "move_id"
    t.integer  "def_move_option_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "moves", force: :cascade do |t|
    t.integer  "character_id"
    t.integer  "def_move_id"
    t.text     "description"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "improvement_id"
  end

  create_table "name_categories", force: :cascade do |t|
    t.string  "name"
    t.integer "archetype_id"
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
    t.string  "name"
    t.integer "archetype_id"
  end

  create_table "spellbooks", force: :cascade do |t|
    t.integer  "character_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "spells", force: :cascade do |t|
    t.integer  "spellbook_id"
    t.string   "name"
    t.boolean  "dangerous"
    t.boolean  "dark"
    t.boolean  "time"
    t.boolean  "attention"
    t.boolean  "spirit"
    t.string   "cost"
    t.text     "effects"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "stat_changes", force: :cascade do |t|
    t.integer "improvement_id"
    t.string  "stat"
    t.integer "value",          default: 1
  end

  create_table "tools", force: :cascade do |t|
    t.integer  "character_id"
    t.integer  "def_tool_id"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "improvement_id"
    t.integer  "replaces"
  end

  create_table "trust_questions", force: :cascade do |t|
    t.string  "question"
    t.integer "trust"
    t.integer "archetype_id"
  end

  create_table "vows", force: :cascade do |t|
    t.integer  "character_id"
    t.integer  "def_vow_id"
    t.string   "detail"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "improvement_id"
    t.integer  "replaces"
  end

end
