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

ActiveRecord::Schema.define(version: 20150505025805) do

  create_table "collections", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "nickname"
    t.string   "stock_id"
    t.string   "quantity"
    t.string   "market_cap"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "historical_stock_prices", force: :cascade do |t|
    t.integer  "stock_id"
    t.decimal  "price"
    t.datetime "last_traded_at"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "stocks", force: :cascade do |t|
    t.string   "ticker"
    t.string   "company_name"
    t.decimal  "current_price",                 precision: 8, scale: 2
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
    t.decimal  "daily_min_price",               precision: 8, scale: 2
    t.decimal  "daily_max_price",               precision: 8, scale: 2
    t.decimal  "dividend_yield",                precision: 8, scale: 2
    t.decimal  "dividend_per_share",            precision: 8, scale: 2
    t.decimal  "percentchange_from200day_avg",  precision: 8, scale: 2
    t.decimal  "percentchange_from50day_avg",   precision: 8, scale: 2
    t.decimal  "percentchange_from52week_low",  precision: 8, scale: 2
    t.decimal  "percentchange_from52week_high", precision: 8, scale: 2
    t.decimal  "volume",                        precision: 8, scale: 2
    t.decimal  "eps",                           precision: 8, scale: 2
    t.decimal  "pe_ratio",                      precision: 8, scale: 2
  end

  create_table "triggers", force: :cascade do |t|
    t.string   "userEmail"
    t.string   "ticker"
    t.decimal  "trigger_price", precision: 8, scale: 2
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "triggertype"
    t.string   "comparison"
    t.boolean  "active"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "password_digest"
    t.string   "email1"
    t.string   "email2"
    t.string   "p_number"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "remember_digest"
    t.boolean  "admin",           default: false
  end

  add_index "users", ["email1"], name: "index_users_on_email1", unique: true

end
