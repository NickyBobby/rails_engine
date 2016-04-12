require 'csv'

namespace :import_transactions do
  desc "Import transactions from csv"
  task transactions: :environment do
    filename = File.join Rails.root, "lib/support/transactions.csv"
    CSV.foreach(filename, headers: true) do |row|
      Transaction.create(id: row["id"],
                         invoice_id: row["invoice_id"],
                         credit_card_number: row["credit_card_number"],
                         credit_card_expiration_date: row["credit_card_expiration_date"],
                         result: row["result"],
                         created_at: row["created_at"],
                         updated_at: row["updated_at"])
      puts "Created transaction: #{row["id"]}"
    end
  end
end
