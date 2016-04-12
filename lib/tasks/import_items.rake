require 'csv'

namespace :import_items do
  desc "Import items from csv"
  task items: :environment do
    filename = File.join Rails.root, "lib/support/items.csv"
    CSV.foreach(filename, headers: true) do |row|
      Item.create(id: row["id"],
                  name: row["name"],
                  description: row["description"],
                  unit_price: row["unit_price"],
                  merchant_id: row["merchant_id"],
                  created_at: row["created_at"],
                  updated_at: row["updated_at"])
      puts "Created item: #{row["name"]}"
    end
  end
end
