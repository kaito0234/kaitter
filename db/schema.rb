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

ActiveRecord::Schema.define(version: 20200723031034) do

  create_table "comments", force: :cascade do |t|
    t.text "text"
    t.integer "user_id"
    t.integer "micropost_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["micropost_id"], name: "index_comments_on_micropost_id"
    t.index ["text"], name: "index_comments_on_text"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.integer "user_id"
    t.string "title"
    t.text "memo"
    t.string "place"
    t.datetime "start"
    t.datetime "end"
    t.string "color"
    t.boolean "allDay"
    t.string "textColor"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["allDay"], name: "index_events_on_allDay"
    t.index ["color"], name: "index_events_on_color"
    t.index ["end"], name: "index_events_on_end"
    t.index ["memo"], name: "index_events_on_memo"
    t.index ["place"], name: "index_events_on_place"
    t.index ["start"], name: "index_events_on_start"
    t.index ["textColor"], name: "index_events_on_textColor"
    t.index ["title"], name: "index_events_on_title"
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "likes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "micropost_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["micropost_id"], name: "index_likes_on_micropost_id"
    t.index ["user_id", "micropost_id"], name: "index_likes_on_user_id_and_micropost_id", unique: true
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "meetings", force: :cascade do |t|
    t.string "name"
    t.datetime "start_time"
    t.integer "user_id"
    t.string "memo"
    t.string "place"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["memo"], name: "index_meetings_on_memo"
    t.index ["name"], name: "index_meetings_on_name"
    t.index ["place"], name: "index_meetings_on_place"
    t.index ["start_time"], name: "index_meetings_on_start_time"
    t.index ["user_id"], name: "index_meetings_on_user_id"
  end

  create_table "microposts", force: :cascade do |t|
    t.text "content"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "picture"
    t.index ["user_id", "created_at"], name: "index_microposts_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_microposts_on_user_id"
  end

  create_table "notices", force: :cascade do |t|
    t.integer "visitor_id", null: false
    t.integer "visited_id", null: false
    t.integer "micropost_id"
    t.integer "comment_id"
    t.string "action", default: "", null: false
    t.boolean "checked", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["comment_id"], name: "index_notices_on_comment_id"
    t.index ["micropost_id"], name: "index_notices_on_micropost_id"
    t.index ["visited_id"], name: "index_notices_on_visited_id"
    t.index ["visitor_id"], name: "index_notices_on_visitor_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "updates", force: :cascade do |t|
    t.string "title"
    t.text "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.boolean "admin", default: false
    t.string "remember_digest"
    t.string "icon"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["name"], name: "index_users_on_name", unique: true
  end

end
