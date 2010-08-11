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

ActiveRecord::Schema.define(:version => 20100811204447) do

  create_table "address_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "address_types", ["name"], :name => "index_address_types_on_name"

  create_table "addresses", :force => true do |t|
    t.string   "name"
    t.string   "address1"
    t.string   "address2"
    t.string   "phone"
    t.string   "fax"
    t.string   "url"
    t.string   "email"
    t.integer  "address_type_id"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.integer  "client_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "addresses", ["address_type_id"], :name => "index_addresses_on_address_type_id"
  add_index "addresses", ["client_id"], :name => "index_addresses_on_client_id"

  create_table "clients", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "clients", ["name"], :name => "index_clients_on_name"

  create_table "project_durations", :force => true do |t|
    t.date     "start"
    t.date     "end"
    t.float    "hours_allocated", :default => 0.0
    t.float    "hours_elapsed",   :default => 0.0
    t.text     "notes"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "project_durations", ["project_id"], :name => "index_project_durations_on_project_id"

  create_table "project_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "project_types", ["name"], :name => "index_project_types_on_name"

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.integer  "code"
    t.integer  "project_type_id"
    t.integer  "project_manager_id"
    t.integer  "client_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state"
  end

  add_index "projects", ["client_id"], :name => "index_projects_on_client_id"
  add_index "projects", ["code"], :name => "index_projects_on_code"
  add_index "projects", ["name"], :name => "index_projects_on_name"
  add_index "projects", ["project_manager_id"], :name => "index_projects_on_project_manager_id"
  add_index "projects", ["project_type_id"], :name => "index_projects_on_project_type_id"
  add_index "projects", ["state"], :name => "index_projects_on_state"

  create_table "status_updates", :force => true do |t|
    t.text     "description"
    t.date     "entry_date",          :default => '2010-08-11'
    t.integer  "user_id"
    t.integer  "project_duration_id"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.integer  "login_count"
    t.datetime "last_request_at"
    t.datetime "last_login_at"
    t.datetime "current_login_at"
    t.string   "last_login_ip"
    t.string   "current_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "email"
    t.string   "initials"
  end

  add_index "users", ["last_request_at"], :name => "index_users_on_last_request_at"
  add_index "users", ["login"], :name => "index_users_on_login"
  add_index "users", ["persistence_token"], :name => "index_users_on_persistence_token"

end
