require 'rails_helper'

describe "transaction search endpoint" do
  context "GET /api/v1/transactions/find?id=1" do
    it "returns transaction with id from params" do

      transaction1 = create(:transaction)
      transaction2 = create(:transaction)

      get "/api/v1/transactions/find?id=#{transaction1.id}"

      transaction_response = JSON.parse(response.body)

      expect(response).to be_success
      expect(transaction_response["id"]).to eq(transaction1.id)

    end
  end
  context "GET /transactions/find_all?parameters" do
    it "returns all transactions with same result" do
      transaction1 = create(:transaction, result: "good")
      transaction2 = create(:transaction, result: "good")
      transaction3 = create(:transaction, result: "bad")

      get "/api/v1/transactions/find_all?result=good"

      transactions = JSON.parse(response.body)

      expect(response).to be_success
      expect(transactions.count).to eq(2)
    end
  end
  context "GET /api/v1/transactions/random" do
    it "returns a random transactions" do

      transaction1 = create(:transaction)
      transaction2 = create(:transaction)
      transaction3 = create(:transaction)

      get "/api/v1/transactions/random"

      transaction_response = JSON.parse(response.body)
      transaction_ids = [transaction1.id, transaction2.id, transaction3.id]

      expect(response).to be_success
      expect(transaction_ids).to include(transaction_response[0]["id"])
    end
  end
end
