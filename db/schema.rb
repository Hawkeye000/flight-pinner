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

ActiveRecord::Schema.define(version: 20141205045817) do

  create_table "airlines", force: true do |t|
    t.string   "name"
    t.string   "iata"
    t.string   "icao"
    t.string   "callsign"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "routes_count", default: 0, null: false
  end

  create_table "airports", force: true do |t|
    t.string   "name"
    t.string   "iata_faa"
    t.string   "icao"
    t.float    "latitude"
    t.float    "longitude"
    t.float    "altitude"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "departing_flights_count", default: 0, null: false
    t.integer  "arriving_flights_count",  default: 0, null: false
    t.string   "country"
    t.string   "city"
  end

  create_table "route_users", force: true do |t|
    t.integer  "user_id"
    t.integer  "route_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "date"
  end

  add_index "route_users", ["route_id"], name: "index_route_users_on_route_id"
  add_index "route_users", ["user_id"], name: "index_route_users_on_user_id"

  create_table "routes", force: true do |t|
    t.integer  "airline_id"
    t.integer  "origin_airport_id"
    t.integer  "destination_airport_id"
    t.integer  "stops"
    t.string   "equipment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
