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

ActiveRecord::Schema.define(version: 20180527204805) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ad_units", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "click_url_default"
    t.string "ad_unit_url"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.string "ad_format"
    t.datetime "last_served_at"
    t.integer "aspect_ratio_width"
    t.integer "aspect_ratio_height"
    t.boolean "rewarded"
    t.boolean "interstitial"
    t.integer "video_length"
    t.string "click_url_android"
    t.string "click_url_ios"
    t.string "click_to_action"
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
    t.string "platform"
    t.string "download_link"
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
    t.integer "interaction_length"
    t.index ["ad_unit_id"], name: "index_impressions_on_ad_unit_id"
    t.index ["app_session_id"], name: "index_impressions_on_app_session_id"
    t.index ["developer_app_id"], name: "index_impressions_on_developer_app_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "account_type"
    t.string "username"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "authentication_token", limit: 30
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
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
