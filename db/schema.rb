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

ActiveRecord::Schema.define(version: 20170518110432) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bishops", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "games", force: :cascade do |t|
    t.string   "name"
    t.string   "result"
    t.integer  "white_player_id"
    t.integer  "black_player_id"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "current_color",   default: "white"
    t.string   "resting_color",   default: "black"
    t.index ["black_player_id"], name: "index_games_on_black_player_id", using: :btree
    t.index ["white_player_id"], name: "index_games_on_white_player_id", using: :btree
  end

  create_table "kings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "knights", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pawns", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pieces", force: :cascade do |t|
    t.string   "color"
    t.boolean  "active"
    t.integer  "x_position"
    t.integer  "y_position"
    t.string   "type"
    t.integer  "game_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_pieces_on_game_id", using: :btree
  end

  create_table "queens", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rooks", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "email"
    t.string   "name"
  end

  add_foreign_key "games", "users", column: "black_player_id"
  add_foreign_key "games", "users", column: "white_player_id"
  add_foreign_key "pieces", "games"
end
