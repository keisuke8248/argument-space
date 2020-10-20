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

ActiveRecord::Schema.define(version: 2020_10_13_183824) do

  create_table "article_comment_replies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "parent_article_comment_id"
    t.bigint "children_article_comment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["children_article_comment_id"], name: "index_article_comment_replies_on_children_article_comment_id"
    t.index ["parent_article_comment_id"], name: "index_article_comment_replies_on_parent_article_comment_id"
  end

  create_table "article_comments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "text", null: false
    t.integer "index"
    t.bigint "article_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["article_id"], name: "index_article_comments_on_article_id"
    t.index ["user_id"], name: "index_article_comments_on_user_id"
  end

  create_table "articles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "title", null: false
    t.text "url", null: false
    t.text "description"
    t.text "author"
    t.text "publishedAt"
    t.text "urlToImage"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "text", null: false
    t.bigint "group_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_comments_on_group_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "evaluations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "good", default: 0, null: false
    t.integer "bad", default: 0, null: false
    t.bigint "article_comment_id"
    t.bigint "user_id"
    t.bigint "children_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["article_comment_id"], name: "index_evaluations_on_article_comment_id"
    t.index ["children_user_id"], name: "index_evaluations_on_children_user_id"
    t.index ["user_id"], name: "index_evaluations_on_user_id"
  end

  create_table "favorites", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "vote", default: 1, null: false, unsigned: true
    t.bigint "comment_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["comment_id"], name: "index_favorites_on_comment_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "group_images", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "src"
    t.bigint "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_group_images_on_group_id"
  end

  create_table "groups", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title", null: false
    t.string "text"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_groups_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "nickname", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "article_comment_replies", "article_comments", column: "children_article_comment_id"
  add_foreign_key "article_comment_replies", "article_comments", column: "parent_article_comment_id"
  add_foreign_key "article_comments", "articles"
  add_foreign_key "article_comments", "users"
  add_foreign_key "comments", "groups"
  add_foreign_key "comments", "users"
  add_foreign_key "evaluations", "article_comments"
  add_foreign_key "evaluations", "users"
  add_foreign_key "evaluations", "users", column: "children_user_id"
  add_foreign_key "favorites", "comments"
  add_foreign_key "favorites", "users"
  add_foreign_key "group_images", "groups"
  add_foreign_key "groups", "users"
end
