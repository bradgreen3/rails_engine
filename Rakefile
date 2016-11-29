# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'
require 'csv'

Rails.application.load_tasks

desc "Imports a CSV file into an ActiveRecord table"
task :import, [:filename] => :environment do
  create_customers
  create_merchants
  create_invoices
  create_items
  create_invoice_items
  create_transactions
end

def create_customers
  CSV.foreach('data/customers.csv', :headers => true) do |row|
    Customer.create!(row.to_hash)
  end
  puts "Imported customers"
end

def create_items
  CSV.foreach('data/items.csv', :headers => true) do |row|
    Item.create!(row.to_hash)
  end
  puts "Imported items"
end

def create_merchants
  CSV.foreach('data/merchants.csv', :headers => true) do |row|
    Merchant.create!(row.to_hash)
  end
  puts "Imported merchants"
end

def create_invoices
  CSV.foreach('data/invoices.csv', :headers => true) do |row|
    Invoice.create!(row.to_hash)
  end
  puts "Imported invoices"
end

def create_invoice_items
  CSV.foreach('data/invoice_items.csv', :headers => true) do |row|
    InvoiceItem.create!(row.to_hash)
  end
  puts "Imported invoice items"
end

def create_transactions
  CSV.foreach('data/transactions.csv', :headers => true) do |row|
    Transaction.create!(row.to_hash)
  end
  puts "Imported transactions"
end
