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

ActiveRecord::Schema.define(:version => 20111115114653) do

  create_table "agari_pais", :force => true do |t|
    t.string   "type"
    t.integer  "number"
    t.boolean  "naki"
    t.string   "direction"
    t.boolean  "agari"
    t.integer  "index"
    t.integer  "agari_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "agaris", :force => true do |t|
    t.boolean  "is_ippatsu",                          :default => false
    t.boolean  "is_parent",                           :default => false
    t.boolean  "is_tsumo",                            :default => false
    t.integer  "dora_num",                            :default => 0
    t.string   "bakaze",                              :default => "none"
    t.string   "jikaze",                              :default => "none"
    t.integer  "honba_num",                           :default => 0
    t.integer  "reach_num",                           :default => 0
    t.boolean  "is_haitei",                           :default => false
    t.boolean  "is_rinshan",                          :default => false
    t.boolean  "is_chankan",                          :default => false
    t.boolean  "is_tenho",                            :default => false
    t.boolean  "is_chiho",                            :default => false
    t.integer  "total_fu_num"
    t.integer  "total_han_num"
    t.integer  "mangan_scale"
    t.integer  "total_point"
    t.integer  "parent_point"
    t.integer  "child_point"
    t.text     "tehai_img",     :limit => 2147483647
    t.string   "tehai_list"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "img_url"
    t.integer  "status_code"
    t.integer  "ron_point"
    t.boolean  "is_furo"
  end

  create_table "agaris_yakus", :id => false, :force => true do |t|
    t.integer "agari_id"
    t.integer "yaku_id"
  end

  create_table "images", :force => true do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "image_remote_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", :force => true do |t|
    t.string   "path"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url"
    t.string   "thum_url"
    t.string   "orig_url"
  end

  create_table "yakus", :force => true do |t|
    t.string   "name_kanji"
    t.string   "name_kana"
    t.integer  "han_num"
    t.integer  "naki_han_num"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

end
