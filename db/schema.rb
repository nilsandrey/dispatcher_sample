# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_12_05_080212) do

  create_table "drones", charset: "utf8mb4", force: :cascade do |t|
    t.string "serial_number", limit: 100
    t.integer "model"
    t.decimal "weight_limit", precision: 10
    t.integer "battery", limit: 1
    t.integer "state"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["model"], name: "index_drones_on_model"
    t.index ["serial_number"], name: "index_drones_on_serial_number", unique: true
    t.index ["state"], name: "index_drones_on_state"
  end

  create_table "medications", charset: "utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.decimal "weight", precision: 10, null: false
    t.string "code", null: false
    t.string "image"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["code"], name: "index_medications_on_code", unique: true
    t.index ["name"], name: "index_medications_on_name", unique: true
  end

end
