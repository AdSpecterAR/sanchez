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

ActiveRecord::Schema.define(version: 20180221000831) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ad_units", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "click_url"
    t.string "ad_unit_url"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_ad_units_on_user_id"
  end

  create_table "api_keys", force: :cascade do |t|
    t.string "key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "developer_app_id"
    t.index ["developer_app_id"], name: "index_api_keys_on_developer_app_id"
  end

  create_table "app_sessions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "developer_app_id"
    t.index ["developer_app_id"], name: "index_app_sessions_on_developer_app_id"
  end

  create_table "developer_apps", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_developer_apps_on_user_id"
  end

  create_table "devices", force: :cascade do |t|
    t.string "device_model"
    t.string "localized_model"
    t.string "device_model_name"
    t.string "name"
    t.string "system_name"
    t.string "system_version"
    t.string "identifier_for_vendor"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "app_session_id"
    t.index ["app_session_id"], name: "index_devices_on_app_session_id"
  end

  create_table "impressions", force: :cascade do |t|
    t.datetime "impression_started_at"
    t.datetime "impression_ended_at"
    t.boolean "clicked"
    t.bigint "developer_app_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "shown_at"
    t.datetime "served_at"
    t.datetime "shown_for_30_seconds_at"
    t.datetime "clicked_at"
    t.boolean "served"
    t.boolean "shown"
    t.boolean "shown_for_30_seconds"
    t.bigint "app_session_id"
    t.bigint "ad_unit_id"
    t.index ["ad_unit_id"], name: "index_impressions_on_ad_unit_id"
    t.index ["app_session_id"], name: "index_impressions_on_app_session_id"
    t.index ["developer_app_id"], name: "index_impressions_on_developer_app_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "account_type"
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "ad_units", "users"
  add_foreign_key "api_keys", "developer_apps"
  add_foreign_key "app_sessions", "developer_apps"
  add_foreign_key "developer_apps", "users"
  add_foreign_key "devices", "app_sessions"
  add_foreign_key "impressions", "ad_units"
  add_foreign_key "impressions", "app_sessions"
  add_foreign_key "impressions", "developer_apps"
end
