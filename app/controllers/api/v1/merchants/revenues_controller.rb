class Api::V1::Merchants::RevenuesController < ApplicationController
	def show
		render json: Merchant.find(params[:merchant_id]).invoices
								.joins(:transactions, :invoice_items)
								.where(transactions: {result: 'success'})
								.sum('invoice_items.quantity * invoice_items.unit_price')
	end
end