require 'rails_helper'

describe 'Items businsess logic' do
	context 'Items most revenue' do
		it 'returns the top items ranked by total revenue generated' do
			item1 = create(:item)
			item2 = create(:item)
			item3 = create(:item)
			invoice1 = create(:invoice)
			invoice2 = create(:invoice)
			transaction1 = create(:transaction, invoice: invoice1, result: 'success')
			transaction1 = create(:transaction, invoice: invoice2, result: 'failed')
			invoice_item1 = create(:invoice_item, invoice: invoice1, item: item1, quantity: 10, unit_price: 1000)
			invoice_item1 = create(:invoice_item, invoice: invoice1, item: item2, quantity: 30, unit_price: 1000)
			invoice_item1 = create(:invoice_item, invoice: invoice1, item: item3, quantity: 20, unit_price: 1000)
			invoice_item1 = create(:invoice_item, invoice: invoice2, item: item1, quantity: 50, unit_price: 1000)

			get "/api/v1/items/most_revenue?quantity=3"

			items_response = JSON.parse(response.body)

			expect(response).to be_success
			expect(items_response.count).to eq(3)
			expect(items_response.first['id']).to eq(item2.id)
			expect(items_response.last['id']).to eq(item1.id)
		end
	end
end