

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

ActiveRecord::Schema.define(version: 2019_08_13_074335) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "business_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "business_category_tags", force: :cascade do |t|
    t.bigint "business_category_id"
    t.bigint "business_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_category_id"], name: "index_business_category_tags_on_business_category_id"
    t.index ["business_id"], name: "index_business_category_tags_on_business_id"
  end

  create_table "businesses", force: :cascade do |t|
    t.string "name"
    t.string "logo"
    t.text "description"
    t.string "location"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_businesses_on_user_id"
  end

  create_table "employees", force: :cascade do |t|
    t.string "roles"
    t.bigint "business_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_employees_on_business_id"
    t.index ["user_id"], name: "index_employees_on_user_id"
  end

  create_table "perk_templates", force: :cascade do |t|
    t.text "description"
    t.integer "amount"
    t.string "kind"
    t.bigint "business_id"
    t.bigint "receiving_product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_perk_templates_on_business_id"
    t.index ["receiving_product_id"], name: "index_perk_templates_on_receiving_product_id"
  end

  create_table "perks", force: :cascade do |t|
    t.string "kind"
    t.integer "amount"
    t.bigint "providing_business_id"
    t.bigint "providing_product_id"
    t.bigint "receiving_product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["providing_business_id"], name: "index_perks_on_providing_business_id"
    t.index ["providing_product_id"], name: "index_perks_on_providing_product_id"
    t.index ["receiving_product_id"], name: "index_perks_on_receiving_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "price_cents"
    t.string "category"
    t.string "photo"
    t.bigint "business_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_products_on_business_id"
  end

  create_table "purchases", force: :cascade do |t|
    t.boolean "verified"
    t.date "expiration_date"
    t.bigint "user_id"
    t.bigint "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_purchases_on_product_id"
    t.index ["user_id"], name: "index_purchases_on_user_id"
  end

  create_table "savings", force: :cascade do |t|
    t.string "kind"
    t.integer "amount"
    t.bigint "perk_id"
    t.bigint "purchase_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["perk_id"], name: "index_savings_on_perk_id"
    t.index ["purchase_id"], name: "index_savings_on_purchase_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "business_category_tags", "business_categories"
  add_foreign_key "business_category_tags", "businesses"
  add_foreign_key "businesses", "users"
  add_foreign_key "employees", "businesses"
  add_foreign_key "employees", "users"
  add_foreign_key "perk_templates", "businesses"
  add_foreign_key "perk_templates", "products", column: "receiving_product_id"
  add_foreign_key "perks", "businesses", column: "providing_business_id"
  add_foreign_key "perks", "products", column: "providing_product_id"
  add_foreign_key "perks", "products", column: "receiving_product_id"
  add_foreign_key "products", "businesses"
  add_foreign_key "purchases", "products"
  add_foreign_key "purchases", "users"
  add_foreign_key "savings", "perks"
  add_foreign_key "savings", "purchases"
end
