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

ActiveRecord::Schema.define(version: 20170203130703) do

  create_table "payments", force: :cascade do |t|
    t.string   "first_name",         limit: 255
    t.string   "last_name",          limit: 255
    t.string   "number",             limit: 255
    t.string   "month",              limit: 255
    t.integer  "year",               limit: 4
    t.string   "verification_value", limit: 255
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "token",              limit: 255
    t.string   "remote_code",        limit: 255
    t.decimal  "amount",             precision: 15, scale: 3
    t.string   "currency",           limit: 255
    t.string   "payment_method_id",  limit: 255
    t.string   "email",              limit: 255
    t.string   "message",            limit: 255
    t.text     "data",               limit: 65535
  end

  create_table "refunds", force: :cascade do |t|
    t.integer  "payment_id",  limit: 4, index: {name: "fk_refunds_payment_id", using: :btree}, foreign_key: {references: "payments", name: "fk_refunds_payment_id", on_update: :restrict, on_delete: :restrict}
    t.decimal  "amount",      precision: 15, scale: 3
    t.string   "remote_code", limit: 255
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "message",     limit: 255
    t.text     "data",        limit: 65535
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false, index: {name: "index_users_on_email", unique: true, using: :btree}
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255, index: {name: "index_users_on_reset_password_token", unique: true, using: :btree}
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "name",                   limit: 255
  end

end
