class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.integer  "subscription_id"
      t.datetime "billed_at"
      t.integer  "amount"
      t.string   "card_number",       :limit => 30
      t.integer  "attemp_count"
      t.string   "status",            :limit => 30
      t.string   "invoice_uid",       :limit => 30
      t.text     "stripe_attributes"
      t.string   "charge_uid"
      t.string   "card_type"
      t.timestamps
    end
    add_index "invoices", :invoice_uid
    add_index "invoices", :status
    add_index "invoices", :subscription_id
  end
end
