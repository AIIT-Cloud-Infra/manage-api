# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_11_02_104906) do

  create_table "base_imgs", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name", null: false
    t.integer "size", null: false
    t.string "path", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "instances", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "uid", null: false
    t.integer "memory", null: false
    t.integer "cpu", null: false
    t.integer "storage", null: false
    t.string "ip_address"
    t.string "mac_address"
    t.string "status", null: false
    t.bigint "base_img_id"
    t.bigint "server_id"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["base_img_id"], name: "index_instances_on_base_img_id"
    t.index ["server_id"], name: "index_instances_on_server_id"
    t.index ["user_id"], name: "index_instances_on_user_id"
  end

  create_table "servers", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "ip_address", null: false
    t.integer "memory", null: false
    t.integer "cpu", null: false
    t.integer "storage", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "ssh_keys", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "value"
    t.bigint "instance_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["instance_id"], name: "index_ssh_keys_on_instance_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "email", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest"
    t.string "remember_digest"
  end

  add_foreign_key "instances", "base_imgs"
  add_foreign_key "instances", "servers"
  add_foreign_key "instances", "users"
  add_foreign_key "ssh_keys", "instances"
end
