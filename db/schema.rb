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

ActiveRecord::Schema[7.0].define(version: 2024_01_03_113704) do
  create_table "attendances", force: :cascade do |t|
    t.integer "employee_id", null: false
    t.datetime "start_work_date"
    t.datetime "end_work_date"
    t.float "break_time", default: 0.0
    t.integer "attendance_modify_flag", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id", "created_at"], name: "index_attendances_on_employee_id_and_created_at"
    t.index ["employee_id"], name: "index_attendances_on_employee_id"
  end

  create_table "employees", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.integer "attendance_flag", default: 0
    t.integer "hourly_wage", default: 0
    t.integer "admin_flag", default: 0
    t.index ["email"], name: "index_employees_on_email", unique: true
  end

  add_foreign_key "attendances", "employees"
end
