require 'rails_helper'

describe "transactions endpoint" do
  context "GET /api/v1/transcsations" do
    it "returns all transactions" do

      create_list(:transaction, 3)

      get "/api/v1/transactions.json"

      transactions = JSON.parse(response.body)

      expect(response).to be_success
      expect(transactions.count).to eq(3)
    end
  end
  context "GET /api/v1/transactions/:id" do
    it "returns a transaction" do

      transaction = create(:transaction, credit_card_number: "1234")

      get "/api/v1/transactions/#{transaction.id}"

      transaction = JSON.parse(response.body)

      expect(response).to be_success
      expect(transaction["credit_card_number"]).to eq("1234")
    end
  end
end
