require 'csv'

desc "Import all CSV files"

task import_csv: :environment do

  filename = "lib/support/customers.csv"
  counter = 0
  CSV.foreach(filename, headers: true) do |row|
    counter += 1
    Customer.create(row.to_h)
    puts "Customer #{counter} created"
  end

  filename = "lib/support/merchants.csv"
  counter = 0
  CSV.foreach(filename, headers: true) do |row|
    counter += 1
    Merchant.create(row.to_h)
    puts "Merchant #{counter} created"
  end

  filename = "lib/support/items.csv"
  counter = 0
  CSV.foreach(filename, headers: true) do |row|
    counter += 1
    Item.create(row.to_h)
    puts "Item #{counter} created"
  end

  filename = "lib/support/invoices.csv"
  counter = 0
  CSV.foreach(filename, headers: true) do |row|
    counter += 1
    Invoice.create(row.to_h)
    puts "Invoice #{counter} created"
  end

  filename = "lib/support/invoice_items.csv"
  counter = 0
  CSV.foreach(filename, headers: true) do |row|
    counter += 1
    InvoiceItem.create(row.to_h)
    puts "Invoice item #{counter} created"
  end

  filename = "lib/support/transactions.csv"
  counter = 0
  CSV.foreach(filename, headers: true) do |row|
    counter += 1
    row.delete("create_card_expiration_date")
    Transaction.create(row.to_h)
    puts "Transaction #{counter} created"
  end
end
