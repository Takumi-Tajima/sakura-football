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

ActiveRecord::Schema[8.0].define(version: 2025_09_09_085522) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "administrators", force: :cascade do |t|
    t.string "email", null: false
    t.string "encrypted_password", null: false
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_administrators_on_email", unique: true
  end

  create_table "bookings", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "lesson_id", null: false
    t.integer "participant_count", null: false
    t.integer "participation_fee", null: false
    t.integer "court_fee", null: false
    t.integer "total_fee", null: false
    t.string "lesson_name", null: false
    t.datetime "lesson_start_at", null: false
    t.datetime "lesson_end_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lesson_id"], name: "index_bookings_on_lesson_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "lessons", force: :cascade do |t|
    t.string "name", null: false
    # 改行反映されてなさそうだった
    t.text "description", null: false
    t.integer "participation_fee", null: false
    t.boolean "is_published", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "position"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "encrypted_password", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "address", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "bookings", "lessons"
  add_foreign_key "bookings", "users"
end
