class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices
  has_many :invoice_items, through: :invoices

  def total_revenue(date=nil)
    date == nil ? tr_no_date : tr_has_date(date)
  end

  def tr_no_date
    invoices.joins(:transactions, :invoice_items)
    .where(transactions: {result: 'success'})
    .sum('invoice_items.quantity * invoice_items.unit_price')
  end

  def tr_has_date(date)
    invoices.joins(:transactions, :invoice_items)
    .where(transactions: {result: 'success'}, invoices: {created_at: date})
    .sum('invoice_items.quantity * invoice_items.unit_price')
  end

  def self.favorite_merchant(customer_id)
    joins(invoices: :transactions)
    .where(transactions: {result: 'success'}, invoices: {customer_id: customer_id})
    .group(:id).order("count (transactions) desc").first
  end

  def self.total_merchants_revenue_by_date(date=nil)
    joins(invoices: [:transactions, :invoice_items])
    .where(transactions: {result: 'success'}, invoices: {created_at: date})
    .sum("invoice_items.quantity * invoice_items.unit_price")
  end

  def self.top_merchants_list(quantity)
    select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue")
    .joins(invoices: [:transactions, :invoice_items])
    .where(transactions: {result: 'success'})
    .group(:id)
    .order("revenue DESC").limit(quantity)
  end

  def self.most_items(num_of_merchants)
    select("merchants.*, sum(invoice_items.quantity) AS items_sold")
    .joins(invoices: [:transactions, :invoice_items])
    .where(transactions: {result: 'success'})
    .group(:id)
    .order("items_sold DESC").limit(num_of_merchants)
  end
end
