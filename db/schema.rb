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

ActiveRecord::Schema.define(version: 20191028015125) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.string "abbreviation"
    t.integer "timezone"
    t.text "flag_image"
  end

  create_table "letters", force: :cascade do |t|
    t.bigint "sender_id"
    t.bigint "country_id"
    t.bigint "user_owl_id"
    t.bigint "receiver_id"
    t.text "content"
    t.datetime "sent_date"
    t.datetime "delivery_date"
    t.datetime "pick_up_date"
    t.index ["country_id"], name: "index_letters_on_country_id"
    t.index ["receiver_id"], name: "index_letters_on_receiver_id"
    t.index ["sender_id"], name: "index_letters_on_sender_id"
    t.index ["user_owl_id"], name: "index_letters_on_user_owl_id"
  end

  create_table "owls", force: :cascade do |t|
    t.string "name"
    t.integer "speed"
    t.integer "carrying_capacity"
    t.text "image"
  end

  create_table "seals", force: :cascade do |t|
    t.bigint "country_id"
    t.string "title"
    t.text "image"
    t.index ["country_id"], name: "index_seals_on_country_id"
  end

  create_table "seals_users", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "seal_id", null: false
  end

  create_table "user_owls", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "owl_id"
    t.index ["owl_id"], name: "index_user_owls_on_owl_id"
    t.index ["user_id"], name: "index_user_owls_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "username"
    t.string "password"
    t.text "avatar"
    t.datetime "join_date"
    t.datetime "last_login"
  end

  add_foreign_key "letters", "countries"
  add_foreign_key "letters", "user_owls"
  add_foreign_key "letters", "users", column: "receiver_id"
  add_foreign_key "letters", "users", column: "sender_id"
  add_foreign_key "seals", "countries"
  add_foreign_key "user_owls", "owls"
  add_foreign_key "user_owls", "users"
end
