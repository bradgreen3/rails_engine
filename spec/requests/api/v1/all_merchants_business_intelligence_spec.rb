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
end
