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

ActiveRecord::Schema.define(version: 20_200_815_215_500) do
  create_table 'categories', force: :cascade do |t|
    t.string 'category'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'tasks', force: :cascade do |t|
    t.string 'name'
    t.string 'description'
    t.datetime 'start'
    t.datetime 'end'
    t.integer 'seconds'
    t.integer 'minutes'
    t.integer 'hours'
    t.integer 'category_id'
    t.integer 'user_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['category_id'], name: 'index_tasks_on_category_id'
    t.index ['user_id'], name: 'index_tasks_on_user_id'
  end

  create_table 'tokens', force: :cascade do |t|
    t.string 'token'
    t.string 'request_ip'
    t.integer 'user_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['token'], name: 'index_tokens_on_token', unique: true
    t.index ['user_id'], name: 'index_tokens_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'full_name'
    t.string 'username'
    t.string 'email'
    t.string 'password_digest'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  add_foreign_key 'tasks', 'categories'
  add_foreign_key 'tasks', 'users'
  add_foreign_key 'tokens', 'users'
end
