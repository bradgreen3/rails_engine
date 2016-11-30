merchant.invoices
.joins(:transactions, :invoice_items)
# .where("transactions.result = 'success'")
.where(transaction {result: 'success'} )
# .merge(Transaction.successful) use this when using a method
.sum('invoice_items.unit_price * invoice_items.quantity')


# on the transaction model
def self.successful
	where(result: 'success')
end

scope :successful, -> { where (result: 'success') }

Merchant
.select("merchant.*, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue") virtual attribute
.joins(:transactions, :invoice_items)
# .where("transactions.result = 'success'")
.merge(Transaction.successful)
.group("invoices").first.revenue using the virtual attribute

