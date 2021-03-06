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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130410015957) do

  create_table "info_fields", :force => true do |t|
    t.string   "associated_object"
    t.string   "associated_role"
    t.string   "label"
    t.string   "content_type"
    t.text     "content"
    t.integer  "sort_order"
    t.string   "category"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "info_values", :force => true do |t|
    t.integer  "info_field_id"
    t.integer  "associated_object_id"
    t.text     "content"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.string   "associated_object_type"
  end

  add_index "info_values", ["info_field_id"], :name => "index_info_values_on_info_field_id"

  create_table "labs", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.text     "description"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.boolean  "is_authorized"
  end

  create_table "labs_principles", :id => false, :force => true do |t|
    t.integer "lab_id"
    t.integer "user_id"
  end

  add_index "labs_principles", ["lab_id", "user_id"], :name => "index_labs_principles_on_lab_id_and_user_id"

  create_table "labs_projects", :id => false, :force => true do |t|
    t.integer "lab_id"
    t.integer "project_id"
  end

  add_index "labs_projects", ["lab_id", "project_id"], :name => "index_labs_projects_on_lab_id_and_project_id"

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.boolean  "is_confirmed"
  end

  create_table "projects_users", :id => false, :force => true do |t|
    t.integer "project_id"
    t.integer "user_id"
  end

  add_index "projects_users", ["project_id", "user_id"], :name => "index_projects_users_on_project_id_and_user_id"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "project_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "taggings", ["project_id"], :name => "index_taggings_on_project_id"
  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.boolean  "is_active"
  end

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

end
