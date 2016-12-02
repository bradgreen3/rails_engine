class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices

  def self.favorite_customer(merchant_id)
  	joins(invoices: :transactions)
  	.where(transactions: {result: 'success'}, invoices: {merchant_id: merchant_id})
		.group(:id).order("count (transactions) desc")
		.first
  end

end
