require 'csv'

namespace :import_invoices do
  desc "Import invoices from csv"
  task invoices: :environment do
    filename = File.join Rails.root, "lib/support/invoices.csv"
    CSV.foreach(filename, headers: true) do |row|
      Invoice.create(id: row["id"],
                     customer_id: row["customer_id"],
                     merchant_id: row["merchant_id"],
                     status: row["status"],
                     created_at: row["created_at"],
                     updated_at: row["updated_at"])
      puts "Created invoice: #{row["id"]}"
    end
  end
end
