require 'csv'

namespace :import_customers do
  desc "Import customers from csv"
  task customers: :environment do
    filename = File.join Rails.root, "lib/support/customers.csv"
    CSV.foreach(filename, headers: true) do |row|
      Customer.create(id: row["id"],
                  first_name: row["first_name"],
                  last_name: row["last_name"],
                  created_at: row["created_at"],
                  updated_at: row["updated_at"])
      puts "Created customer: #{row["first_name"]} #{row["last_name"]}"
    end
  end
end
