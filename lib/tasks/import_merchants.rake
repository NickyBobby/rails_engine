require 'csv'

namespace :import_merchants do
  desc "Import merchants from csv"
  task merchants: :environment do
    filename = File.join Rails.root, "lib/support/merchants.csv"
    CSV.foreach(filename, headers: true) do |row|
      Merchant.create(id: row["id"],
                      name: row["name"],
                      created_at: row["created_at"],
                      updated_at: row["updated_at"])
      puts "Created merchant: #{row["name"]}"
    end
  end
end
