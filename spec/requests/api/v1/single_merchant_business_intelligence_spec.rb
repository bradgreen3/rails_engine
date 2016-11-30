require 'rails_helper'

describe 'Single merchant business intelligence' do
	context 'revenue' do
		it 'calculated the revenue for one merchant' do
			merchant = create(:merchant)
			invoice1 = create(:invoice, merchant: merchant)
			invoice2 = create(:invoice, merchant: merchant)
			invoice3 = create(:invoice, merchant: merchant)
			invoice4 = create(:invoice)
			transaction = create(:transaction, invoice: invoice1, result: 'success')
			transaction = create(:transaction, invoice: invoice2, result: 'success')
			transaction = create(:transaction, invoice: invoice3, result: 'failed')
			transaction = create(:transaction, invoice: invoice4, result: 'success')
			invoice_item = create(:invoice_item, invoice: invoice1, quantity: 10, unit_price: 500)
			invoice_item = create(:invoice_item, invoice: invoice2, quantity: 10, unit_price: 1000)
			invoice_item = create(:invoice_item, invoice: invoice3, quantity: 10, unit_price: 500)
			invoice_item = create(:invoice_item, invoice: invoice4, quantity: 10, unit_price: 1000)

			get "/api/v1/merchants/#{merchant.id}/revenue"

			merchant_response = JSON.parse(response.body)


			expect(merchant_response).to eq('150.00')
		end
	end	
end