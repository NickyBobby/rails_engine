require 'csv'

namespace :import_invoice_items do
  desc "Import invoice items from csv"
  task invoice_items: :environment do
    filename = File.join Rails.root, "lib/support/invoice_items.csv"
    CSV.foreach(filename, headers: true) do |row|
      InvoiceItem.create(id: row["id"],
                         item_id: row["item_id"],
                         invoice_id: row["invoice_id"],
                         quantity: row["quantity"],
                         unit_price: row["unit_price"],
                         created_at: row["created_at"],
                         updated_at: row["updated_at"])
      puts "Created invoice item: #{row["item_id"]}"
    end
  end
end
