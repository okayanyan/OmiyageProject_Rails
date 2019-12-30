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

ActiveRecord::Schema.define(version: 2019_12_25_032731) do

  create_table "favorites", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_favorites_on_post_id"
    t.index ["user_id", "post_id"], name: "index_favorites_on_user_id_and_post_id", unique: true
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "follow_users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "following_user_id"
    t.bigint "target_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["following_user_id", "target_user_id"], name: "index_follow_users_on_following_user_id_and_target_user_id", unique: true
    t.index ["following_user_id"], name: "index_follow_users_on_following_user_id"
    t.index ["target_user_id"], name: "index_follow_users_on_target_user_id"
  end

  create_table "posts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.string "title"
    t.string "image_key"
    t.bigint "prefecture_id"
    t.integer "evaluation"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["prefecture_id"], name: "index_posts_on_prefecture_id"
    t.index ["user_id", "prefecture_id", "created_at"], name: "index_posts_on_user_id_and_prefecture_id_and_created_at"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "prefectures", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", limit: 20
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "remember_digest"
    t.string "image_key"
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
  end

  add_foreign_key "favorites", "posts"
  add_foreign_key "favorites", "users"
  add_foreign_key "follow_users", "users", column: "following_user_id"
  add_foreign_key "follow_users", "users", column: "target_user_id"
  add_foreign_key "posts", "prefectures"
  add_foreign_key "posts", "users"
end
