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
<<<<<<< HEAD
=======

>>>>>>> master
  context "GET /api/v1/transactions/:id" do
    it "returns a transaction" do

      transaction = create(:transaction, credit_card_number: "1234")

      get "/api/v1/transactions/#{transaction.id}"

      transaction_response = JSON.parse(response.body)

      expect(response).to be_success
      expect(transaction_response["credit_card_number"]).to eq("1234")
       expect(transaction_response["created_at"]).to eq(nil)
      expect(transaction_response["updated_at"]).to eq(nil)
      expect(transaction_response["credit_card_expiration_date"]).to eq(nil)
    end
  end

  context "GET /api/v1/transactions/:id/invoice" do
    it "returns a transactions invoice" do
      invoice = create(:invoice, status: 'Test Paid')
      transaction = create(:transaction, invoice: invoice)

      get "/api/v1/transactions/#{transaction.id}/invoice"

      invoice_response = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_response['id']).to eq(invoice.id)
      expect(invoice_response['status']).to eq('Test Paid')
    end
  end
end
