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

ActiveRecord::Schema[7.0].define(version: 2022_09_22_023130) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "addresses", force: :cascade do |t|
    t.string "addressable_type", null: false
    t.bigint "addressable_id", null: false
    t.string "line_one", null: false
    t.string "line_two", null: false
    t.string "city", null: false
    t.string "province", null: false
    t.string "country", null: false
    t.string "postal_code", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable"
  end

  create_table "appointments", force: :cascade do |t|
    t.bigint "service_id", null: false
    t.datetime "timeslot", null: false
    t.integer "max_slots", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["service_id", "timeslot"], name: "index_appointments_on_service_id_and_timeslot", unique: true
    t.index ["service_id"], name: "index_appointments_on_service_id"
  end

  create_table "booking_statuses", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_booking_statuses_on_name", unique: true
  end

  create_table "bookings", force: :cascade do |t|
    t.bigint "receipt_id", null: false
    t.bigint "service_id"
    t.bigint "booking_status_id"
    t.string "service_name", null: false
    t.datetime "service_appointment", null: false
    t.decimal "service_unit_price", precision: 10, scale: 2, null: false
    t.string "service_currency", null: false
    t.integer "slots", null: false
    t.text "addon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["booking_status_id"], name: "index_bookings_on_booking_status_id"
    t.index ["receipt_id"], name: "index_bookings_on_receipt_id"
    t.index ["service_id"], name: "index_bookings_on_service_id"
  end

  create_table "businesses", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.string "timezone", default: "UTC", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_businesses_on_user_id"
  end

  create_table "cart_items", force: :cascade do |t|
    t.bigint "cart_id", null: false
    t.bigint "service_id", null: false
    t.bigint "appointment_id", null: false
    t.text "addon"
    t.integer "slots", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["appointment_id"], name: "index_cart_items_on_appointment_id"
    t.index ["cart_id"], name: "index_cart_items_on_cart_id"
    t.index ["service_id"], name: "index_cart_items_on_service_id"
  end

  create_table "carts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_carts_on_user_id"
  end

  create_table "payment_options", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_payment_options_on_name", unique: true
  end

  create_table "receipts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "payment_option_id", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email", null: false
    t.string "contact_number", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_receipts_on_email"
    t.index ["payment_option_id"], name: "index_receipts_on_payment_option_id"
    t.index ["user_id"], name: "index_receipts_on_user_id"
  end

  create_table "service_categories", force: :cascade do |t|
    t.bigint "business_id", null: false
    t.string "name", null: false
    t.text "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_service_categories_on_business_id"
  end

  create_table "services", force: :cascade do |t|
    t.bigint "business_id", null: false
    t.bigint "service_category_id"
    t.string "name", null: false
    t.text "description", null: false
    t.decimal "unit_price", precision: 10, scale: 2, null: false
    t.string "currency", default: "PHP", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id", "name"], name: "index_services_on_business_id_and_name", unique: true
    t.index ["business_id"], name: "index_services_on_business_id"
    t.index ["service_category_id"], name: "index_services_on_service_category_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email", null: false
    t.string "password_digest"
    t.boolean "admin", default: false
    t.string "timezone", default: "UTC"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "appointments", "services"
  add_foreign_key "bookings", "booking_statuses"
  add_foreign_key "bookings", "receipts"
  add_foreign_key "bookings", "services"
  add_foreign_key "businesses", "users"
  add_foreign_key "cart_items", "appointments"
  add_foreign_key "cart_items", "carts"
  add_foreign_key "cart_items", "services"
  add_foreign_key "carts", "users"
  add_foreign_key "receipts", "payment_options"
  add_foreign_key "receipts", "users"
  add_foreign_key "services", "businesses"
  add_foreign_key "services", "service_categories"
end
