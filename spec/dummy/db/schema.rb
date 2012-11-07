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

ActiveRecord::Schema.define(:version => 20121105212724) do

  create_table "clipster_clips", :force => true do |t|
    t.string   "url_hash",   :default => "",         :null => false
    t.text     "clip",       :default => "",         :null => false
    t.string   "language",                           :null => false
    t.string   "title",      :default => "Untitled", :null => false
    t.boolean  "private",    :default => false,      :null => false
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.datetime "expires"
  end

  add_index "clipster_clips", ["url_hash"], :name => "index_clipster_clips_on_hash", :unique => true

end
