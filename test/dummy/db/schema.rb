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

ActiveRecord::Schema.define(version: 20170728193832) do

  create_table "api_credentials", force: :cascade do |t|
    t.integer "user_id"
    t.integer "organization_id"
    t.string "access_key"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "enabled", default: true, null: false
    t.integer "organization_user_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "organizations_users", force: :cascade do |t|
    t.integer "organization_id", null: false
    t.integer "user_id", null: false
    t.boolean "primary", default: false, null: false
  end

  create_table "organizations_users_roles", force: :cascade do |t|
    t.integer "organization_user_id"
    t.integer "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string "uuid"
    t.string "name"
    t.integer "organization_id"
    t.text "quota_set"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.text "permissions"
    t.boolean "power_user", default: false, null: false
    t.integer "organization_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uuid"
  end

  create_table "roles_users", force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_project_roles", force: :cascade do |t|
    t.integer "user_id"
    t.integer "project_id"
    t.string "role_uuid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "organization_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "uuid"
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password_digest"
    t.integer "organization_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
