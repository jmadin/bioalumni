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

ActiveRecord::Schema.define(version: 20150305233749) do

  create_table "alums", force: true do |t|
    t.integer  "user_id"
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "sex"
    t.date     "dob"
    t.string   "mq_id"
    t.text     "alum_notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "linked_in"
    t.string   "twitter"
    t.string   "facebook"
  end

  add_index "alums", ["user_id"], name: "index_alums_on_user_id"

  create_table "careers", force: true do |t|
    t.integer  "user_id"
    t.string   "career_name"
    t.string   "career_type"
    t.string   "career_system"
    t.text     "career_notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "careers", ["user_id"], name: "index_careers_on_user_id"

  create_table "degree_types", force: true do |t|
    t.string   "degree_type_name"
    t.text     "degree_type_notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "degrees", force: true do |t|
    t.integer  "alum_id"
    t.date     "graduation_year"
    t.string   "thesis_title"
    t.text     "degree_notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "degree_type_id"
    t.date     "approval_year"
  end

  add_index "degrees", ["alum_id"], name: "index_degrees_on_alum_id"
  add_index "degrees", ["degree_type_id"], name: "index_degrees_on_degree_type_id"

  create_table "degrees_users", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "degree_id"
  end

  create_table "photos", force: true do |t|
    t.string   "photo_filename"
    t.integer  "user_id"
    t.date     "photo_date"
    t.text     "photo_notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photograph_file_name"
    t.string   "photograph_content_type"
    t.integer  "photograph_file_size"
    t.datetime "photograph_updated_at"
    t.integer  "alum_id"
  end

  add_index "photos", ["alum_id"], name: "index_photos_on_alum_id"
  add_index "photos", ["user_id"], name: "index_photos_on_user_id"

  create_table "records", force: true do |t|
    t.integer  "user_id"
    t.integer  "alum_id"
    t.integer  "career_id"
    t.string   "work_link"
    t.string   "email"
    t.string   "phone"
    t.text     "record_notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "position_title"
    t.date     "record_date"
    t.string   "company_name"
    t.date     "until_date"
  end

  add_index "records", ["alum_id"], name: "index_records_on_alum_id"
  add_index "records", ["career_id"], name: "index_records_on_career_id"
  add_index "records", ["user_id"], name: "index_records_on_user_id"

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", force: true do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin"
    t.string   "surname"
    t.datetime "last_seen_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

  create_table "users_degrees", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "degree_id"
  end

end
