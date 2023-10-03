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

ActiveRecord::Schema[7.0].define(version: 2023_10_03_164644) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_trgm"
  enable_extension "plpgsql"

  create_table "asset_classes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_asset_classes_on_deleted_at"
    t.index ["name"], name: "index_asset_classes_on_name", unique: true
  end

  create_table "asset_classes_companies", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.bigint "asset_class_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["asset_class_id"], name: "index_asset_classes_companies_on_asset_class_id"
    t.index ["company_id"], name: "index_asset_classes_companies_on_company_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "logotype"
  end

  create_table "companies_job_functions", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.bigint "job_function_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_companies_job_functions_on_company_id"
    t.index ["job_function_id"], name: "index_companies_job_functions_on_job_function_id"
  end

  create_table "companies_locations", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.bigint "location_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_companies_locations_on_company_id"
    t.index ["location_id"], name: "index_companies_locations_on_location_id"
  end

  create_table "companies_practices", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.bigint "practice_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_companies_practices_on_company_id"
    t.index ["practice_id"], name: "index_companies_practices_on_practice_id"
  end

  create_table "csv_uploads", force: :cascade do |t|
    t.string "csv_filename", null: false
    t.jsonb "csv_content", null: false
    t.jsonb "companies_applied"
    t.jsonb "companies_failed"
    t.jsonb "companies_discarded"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_csv_uploads_on_user_id"
  end

  create_table "job_functions", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_job_functions_on_deleted_at"
    t.index ["name"], name: "index_job_functions_on_name", unique: true
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_locations_on_deleted_at"
    t.index ["name"], name: "index_locations_on_name", unique: true
  end

  create_table "practices", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_practices_on_deleted_at"
    t.index ["name"], name: "index_practices_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "asset_classes_companies", "asset_classes"
  add_foreign_key "asset_classes_companies", "companies"
  add_foreign_key "companies_job_functions", "companies"
  add_foreign_key "companies_job_functions", "job_functions"
  add_foreign_key "companies_locations", "companies"
  add_foreign_key "companies_locations", "locations"
  add_foreign_key "companies_practices", "companies"
  add_foreign_key "companies_practices", "practices"
  add_foreign_key "csv_uploads", "users"
end
