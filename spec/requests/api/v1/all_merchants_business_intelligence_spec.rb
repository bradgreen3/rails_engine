require 'rails_helper'

describe 'all merchants business intelligence' do
	context 'revenue' do
		it 'calculated the revenue for x merchants' do
			merchant1 = create(:merchant)
      merchant2 = create(:merchant)
      merchant3 = create(:merchant)
			invoice1 = create(:invoice, merchant: merchant1)
			invoice2 = create(:invoice, merchant: merchant2)
			invoice3 = create(:invoice, merchant: merchant3)
			transaction = create(:transaction, invoice: invoice1, result: 'success')
			transaction = create(:transaction, invoice: invoice2, result: 'success')
			transaction = create(:transaction, invoice: invoice2, result: 'success')
      transaction = create(:transaction, invoice: invoice2, result: 'success')
			transaction = create(:transaction, invoice: invoice3, result: 'success')
			transaction = create(:transaction, invoice: invoice3, result: 'success')
			invoice_item = create(:invoice_item, invoice: invoice1, quantity: 10, unit_price: 500)
			invoice_item = create(:invoice_item, invoice: invoice2, quantity: 10, unit_price: 1000)
			invoice_item = create(:invoice_item, invoice: invoice3, quantity: 10, unit_price: 500)

			get "/api/v1/merchants/most_revenue?quantity=3"

			merchant_response = JSON.parse(response.body)

			expect(merchant_response.first['id']).to eq(merchant2.id)

		end
	end
  context 'items' do
		it 'returns top x merchants by total number of items sold' do
			merchant1 = create(:merchant)
      merchant2 = create(:merchant)
      merchant3 = create(:merchant)
			invoice1 = create(:invoice, merchant: merchant1)
			invoice2 = create(:invoice, merchant: merchant2)
			invoice3 = create(:invoice, merchant: merchant3)
      transaction = create(:transaction, invoice: invoice1, result: 'success')
      transaction = create(:transaction, invoice: invoice2, result: 'success')
      transaction = create(:transaction, invoice: invoice3, result: 'success')
			invoice_item = create(:invoice_item, invoice: invoice1, quantity: 10)
			invoice_item = create(:invoice_item, invoice: invoice2, quantity: 30)
			invoice_item = create(:invoice_item, invoice: invoice3, quantity: 20)

			get "/api/v1/merchants/most_items?quantity=3"

			merchant_response = JSON.parse(response.body)
			expect(merchant_response.first['id']).to eq(merchant2.id)
      expect(merchant_response.count).to eq(3)

		end
	end
  context 'revenue by date' do
		it 'returns total revenue for given date across all merchants' do
			merchant1 = create(:merchant)
      merchant2 = create(:merchant)
			invoice1 = create(:invoice, merchant: merchant1, created_at: "1990-01-20 12:00:00")
			invoice2 = create(:invoice, merchant: merchant2, created_at: "1990-01-20 12:00:00")
      invoice3 = create(:invoice, merchant: merchant2, created_at: "2000-01-20 12:03:00")
      invoice4 = create(:invoice, merchant: merchant2, created_at: "1990-01-20 12:00:00")
      transaction1 = create(:transaction, invoice: invoice1, result: 'success')
      transaction2 = create(:transaction, invoice: invoice2, result: 'success')
      transaction2 = create(:transaction, invoice: invoice3, result: 'success')
      transaction3 = create(:transaction, invoice: invoice4, result: 'failed')
			invoice_item1 = create(:invoice_item, invoice: invoice1, quantity: 10, unit_price: 100)
			invoice_item2 = create(:invoice_item, invoice: invoice2, quantity: 30, unit_price: 100)
			invoice_item3 = create(:invoice_item, invoice: invoice3, quantity: 30, unit_price: 100)
			invoice_item4 = create(:invoice_item, invoice: invoice4, quantity: 30, unit_price: 100)

      date = "1990-01-20 12:00:00"
			get "/api/v1/merchants/revenue?date=#{date}"

			merchant_response = JSON.parse(response.body)
      expect(merchant_response["total_revenue"]).to eq("40.00")
		end
	end
end
