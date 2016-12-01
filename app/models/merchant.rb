class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices

  def total_revenue
  	{revenue: dollarize(self.invoices.joins(:transactions, :invoice_items)
														.where(transactions: {result: 'success'})
														.sum('invoice_items.quantity * invoice_items.unit_price')
												)}
  end


  def dollarize(result)
  	'%.2f' % (result / 100.00).to_s
  end

end
