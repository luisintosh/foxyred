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

ActiveRecord::Schema.define(version: 20170208190142) do

  create_table "ads", force: :cascade do |t|
    t.boolean  "default"
    t.string   "position"
    t.string   "network"
    t.text     "code"
    t.string   "type"
    t.decimal  "price",          precision: 10, scale: 5, default: "0.0", null: false
    t.string   "traffic_source"
    t.string   "countries"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "weight"
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
  end

  create_table "ahoy_events", force: :cascade do |t|
    t.integer  "visit_id"
    t.integer  "user_id"
    t.string   "name"
    t.text     "properties"
    t.datetime "time"
    t.index ["name", "time"], name: "index_ahoy_events_on_name_and_time"
    t.index ["user_id", "name"], name: "index_ahoy_events_on_user_id_and_name"
    t.index ["visit_id", "name"], name: "index_ahoy_events_on_visit_id_and_name"
  end

  create_table "balances", force: :cascade do |t|
    t.integer  "user_id"
    t.decimal  "publisher_earnings", precision: 12, scale: 4, default: "0.0", null: false
    t.decimal  "referral_earnings",  precision: 12, scale: 4, default: "0.0", null: false
    t.datetime "created_at",                                                  null: false
    t.datetime "updated_at",                                                  null: false
    t.index ["user_id"], name: "index_balances_on_user_id"
  end

  create_table "links", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "status"
    t.string   "url"
    t.string   "alias"
    t.integer  "hits",       default: 0, null: false
    t.integer  "real_hits",  default: 0, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["alias"], name: "index_links_on_alias", unique: true
    t.index ["user_id"], name: "index_links_on_user_id"
  end

  create_table "options", force: :cascade do |t|
    t.string   "name"
    t.string   "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "datatype"
  end

  create_table "pages", force: :cascade do |t|
    t.string   "title"
    t.string   "slug"
    t.text     "content"
    t.boolean  "published"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payout_rates", force: :cascade do |t|
    t.string   "country"
    t.string   "country_code"
    t.decimal  "earn",         precision: 5, scale: 2
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "statistics", force: :cascade do |t|
    t.integer  "link_id"
    t.string   "user_agent"
    t.string   "ip"
    t.string   "country"
    t.string   "referrer_domain"
    t.decimal  "publisher_earn",  precision: 11, scale: 4, default: "0.0", null: false
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
    t.index ["link_id"], name: "index_statistics_on_link_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "role"
    t.integer  "referred_by"
    t.string   "referral_code"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address"
    t.string   "tel"
    t.string   "withdrawal_method"
    t.string   "withdrawal_account"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["referral_code"], name: "index_users_on_referral_code", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "visits", force: :cascade do |t|
    t.string   "visit_token"
    t.string   "visitor_token"
    t.string   "ip"
    t.text     "user_agent"
    t.text     "referrer"
    t.text     "landing_page"
    t.integer  "user_id"
    t.string   "referring_domain"
    t.string   "search_keyword"
    t.string   "browser"
    t.string   "os"
    t.string   "device_type"
    t.integer  "screen_height"
    t.integer  "screen_width"
    t.string   "country"
    t.string   "region"
    t.string   "city"
    t.string   "postal_code"
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.string   "utm_source"
    t.string   "utm_medium"
    t.string   "utm_term"
    t.string   "utm_content"
    t.string   "utm_campaign"
    t.datetime "started_at"
    t.index ["user_id"], name: "index_visits_on_user_id"
    t.index ["visit_token"], name: "index_visits_on_visit_token", unique: true
  end

  create_table "withdrawals", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "transaction_id"
    t.integer  "status"
    t.string   "method"
    t.string   "account"
    t.decimal  "amount",             precision: 12, scale: 4
    t.decimal  "referral_earnings",  precision: 12, scale: 4
    t.decimal  "publisher_earnings", precision: 12, scale: 4
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.index ["user_id"], name: "index_withdrawals_on_user_id"
  end

end
