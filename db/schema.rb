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

ActiveRecord::Schema.define(version: 2018_08_25_225137) do

  create_table "messages", force: :cascade do |t|
    t.string "snippet_id"
    t.string "author"
    t.string "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string "hashcode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reponses", force: :cascade do |t|
    t.string "sender_id"
    t.string "body"
    t.date "sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "snippets", force: :cascade do |t|
    t.string "slug"
    t.string "code"
    t.string "title"
    t.string "language"
    t.string "stack"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "theme"
    t.integer "project_id"
  end

  create_table "users", force: :cascade do |t|
    t.integer "sender_id"
    t.string "snippet_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
