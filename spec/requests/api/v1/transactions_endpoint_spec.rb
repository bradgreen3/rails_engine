require 'rails_helper'

describe "transactions endpoint" do
  context "GET /api/v1/transcsations" do
    xit "returns all transactions" do

      create_list(:transaction, 3)

      get "/api/v1/transactions.json"

      transactions = JSON.parse(response.body)

      expect(response).to be_success
      expect(transactions.count).to eq(3)
    end
  end
end
