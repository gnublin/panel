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

ActiveRecord::Schema.define(version: 20170217072315) do

  create_table "pages", force: :cascade do |t|
    t.string   "title"
    t.string   "url"
    t.boolean  "active"
    t.string   "email"
    t.string   "basic_auth"
    t.string   "basic_password"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "site_id"
    t.string   "size"
    t.string   "device"
    t.string   "useragent"
    t.index ["site_id"], name: "index_pages_on_site_id"
  end

  create_table "runs", force: :cascade do |t|
    t.integer  "page_id"
    t.text     "har"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.boolean  "manual"
    t.string   "size"
    t.string   "device"
    t.string   "url"
    t.integer  "requests"
    t.integer  "postRequests"
    t.integer  "httpsRequests"
    t.integer  "notFound"
    t.integer  "timeToFirstByte"
    t.integer  "timeToLastByte"
    t.integer  "bodySize"
    t.integer  "contentLength"
    t.integer  "httpTrafficCompleted"
    t.index ["page_id"], name: "index_runs_on_page_id"
  end

  create_table "sites", force: :cascade do |t|
    t.string   "name"
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "active"
    t.integer  "user_id"
    t.index ["user_id"], name: "index_sites_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "admin",                  default: false
    t.integer  "failed_attempts",        default: 0,     null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

end
