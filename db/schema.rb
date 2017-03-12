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

ActiveRecord::Schema.define(version: 20170312011427) do

  create_table "attendances", force: :cascade do |t|
    t.integer "semester_id"
    t.integer "student_id"
    t.date    "date"
    t.boolean "present"
    t.index ["semester_id"], name: "index_attendances_on_semester_id"
    t.index ["student_id"], name: "index_attendances_on_student_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "name"
  end

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.string   "url"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "projects_students", id: false, force: :cascade do |t|
    t.integer "project_id", null: false
    t.integer "student_id", null: false
    t.index ["project_id"], name: "index_projects_students_on_project_id"
    t.index ["student_id"], name: "index_projects_students_on_student_id"
  end

  create_table "semesters", force: :cascade do |t|
    t.integer "course_id"
    t.string  "name"
    t.boolean "active"
    t.index ["course_id"], name: "index_semesters_on_course_id"
  end

  create_table "semesters_students", id: false, force: :cascade do |t|
    t.integer "semester_id", null: false
    t.integer "student_id",  null: false
  end

  create_table "stand_ups", force: :cascade do |t|
    t.integer "project_id"
    t.integer "student_id"
    t.date    "date"
    t.text    "completed"
    t.text    "goals"
    t.text    "obstacles"
    t.index ["project_id"], name: "index_stand_ups_on_project_id"
    t.index ["student_id"], name: "index_stand_ups_on_student_id"
  end

  create_table "students", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "slack_name"
    t.text     "notes"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "email"
    t.string   "phone_number"
  end

  create_table "users", force: :cascade do |t|
    t.boolean  "teacher"
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
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
