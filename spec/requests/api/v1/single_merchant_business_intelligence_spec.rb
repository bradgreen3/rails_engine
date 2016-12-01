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

			expect(merchant_response['revenue']).to eq('150.00')
		end
	end

	context 'favorite customer' do
		it 'returns the customer who has conducted the most total number of successful transactions.' do
			merchant = create(:merchant)
			customer1 = create(:customer)
			customer2 = create(:customer)
			invoice1 = create(:invoice, merchant: merchant, customer: customer1)
			invoice2 = create(:invoice, merchant: merchant, customer: customer1)
			invoice3 = create(:invoice, merchant: merchant, customer: customer2)
			invoice4 = create(:invoice, merchant: merchant, customer: customer2)
			transaction = create(:transaction, invoice: invoice1, result: 'success')
			transaction = create(:transaction, invoice: invoice2, result: 'failed')
			transaction = create(:transaction, invoice: invoice3, result: 'success')
			transaction = create(:transaction, invoice: invoice4, result: 'success')

			get "/api/v1/merchants/#{merchant.id}/favorite_customer"

			customer_response = JSON.parse(response.body)

			expect(customer_response['id']).to eq(customer2.id)
		end
	end
	
	context 'revenue' do
		it 'calculated the revenue for one merchant for specific invoice date' do
			merchant = create(:merchant)
			invoice1 = create(:invoice, merchant: merchant, created_at: "2001-01-01 12:00:00")
			invoice2 = create(:invoice, merchant: merchant, created_at: "2001-01-01 12:00:00")
			invoice3 = create(:invoice, merchant: merchant, created_at: "1990-01-20 5:00:00")
			transaction = create(:transaction, invoice: invoice1, result: 'success')
			transaction = create(:transaction, invoice: invoice2, result: 'success')
			transaction = create(:transaction, invoice: invoice3, result: 'success')
			transaction = create(:transaction, invoice: invoice2, result: 'failed')
			invoice_item = create(:invoice_item, invoice: invoice1, quantity: 10, unit_price: 500)
			invoice_item = create(:invoice_item, invoice: invoice2, quantity: 10, unit_price: 1000)
			invoice_item = create(:invoice_item, invoice: invoice3, quantity: 10, unit_price: 500)

			date = "2001-01-01 12:00:00"
			get "/api/v1/merchants/#{merchant.id}/revenue?date=#{date}"

			merchant_response = JSON.parse(response.body)

			expect(merchant_response['revenue']).to eq('150.00')
		end
	end
end
