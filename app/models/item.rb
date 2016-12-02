class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

   def self.most_revenue(number_of_items)
  	select("items.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue")
    .joins(invoices: [:transactions, :invoice_items])
    .where(transactions: {result: 'success'})
    .group('id')
    .order("revenue DESC")
    .limit(number_of_items)
  end
end
