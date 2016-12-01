require 'rails_helper'

describe "single customer business intelligence" do
  context "favorite merchant" do
    it "returns a merchant where the customer has conducted the most frequent successful transactions" do
      customer = create(:customer)
      merchant1 = create(:merchant)
      merchant2 = create(:merchant)
      invoice1 = create(:invoice, merchant: merchant1, customer: customer)
      invoice2 = create(:invoice, merchant: merchant1, customer: customer)
      invoice3 = create(:invoice, merchant: merchant1, customer: customer)
      invoice4 = create(:invoice, merchant: merchant2, customer: customer)
      transaction = create(:transaction, invoice: invoice1, result: 'success')
      transaction = create(:transaction, invoice: invoice2, result: 'success')
      transaction = create(:transaction, invoice: invoice3, result: 'failed')
      transaction = create(:transaction, invoice: invoice4, result: 'success')

      get "/api/v1/customers/#{customer.id}/favorite_merchant"

      merchant_response = JSON.parse(response.body)

      expect(merchant_response['id']).to eq(merchant1.id)
    end
  end
end
