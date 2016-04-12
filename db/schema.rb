ActiveRecord::Schema.define(version: 20160412021653) do

  create_table "customers", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invoice_items", force: :cascade do |t|
    t.integer  "item_id"
    t.integer  "invoice_id"
    t.integer  "quantity"
    t.integer  "unit_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "invoice_items", ["invoice_id"], name: "index_invoice_items_on_invoice_id"
  add_index "invoice_items", ["item_id"], name: "index_invoice_items_on_item_id"

  create_table "invoices", force: :cascade do |t|
    t.integer  "customer_id"
    t.integer  "merchant_id"
    t.string   "status"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "invoices", ["customer_id"], name: "index_invoices_on_customer_id"
  add_index "invoices", ["merchant_id"], name: "index_invoices_on_merchant_id"

  create_table "items", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "unit_price"
    t.integer  "merchant_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "items", ["merchant_id"], name: "index_items_on_merchant_id"

  create_table "merchants", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.integer  "invoice_id"
    t.string   "credit_card_number"
    t.string   "credit_card_expiration_date"
    t.string   "result"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "transactions", ["invoice_id"], name: "index_transactions_on_invoice_id"

end
