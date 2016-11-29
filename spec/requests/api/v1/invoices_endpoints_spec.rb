require 'rails_helper'

describe "invoices endpoint" do
  context "GET /invoices" do
    it "returns all invoices" do
      create_list(:invoice, 3)

      get "/api/v1/invoices.json"

      invoices = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoices.count).to eq(3)
    end
  end
  context "GET /invoices/:id" do
    it "returns a invoice" do
      invoice = create(:invoice, status: "Is Paid")

      get "/api/v1/invoices/#{invoice.id}"

      invoice = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice["status"]).to eq("Is Paid")
    end
  end
  context "GET /invoices/:id/customer" do
    it "returns associated customer" do
      customer = create(:customer, first_name: "brad")
      invoice = create(:invoice, customer: customer)

      get "/api/v1/invoices/#{invoice.id}/customer"

      customer_response = JSON.parse(response.body)

      expect(response).to be_success
      expect(customer_response["first_name"]).to eq("brad")
      expect(customer_response["id"]).to eq(customer.id)
    end
  end
  context "GET /invoices/:id/merchant" do
    it "returns associated merchant" do
      merchant = create(:merchant, name: "brad")
      invoice = create(:invoice, merchant: merchant)

      get "/api/v1/invoices/#{invoice.id}/merchant"

      merchant_response = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant_response["name"]).to eq("brad")
      expect(merchant_response["id"]).to eq(merchant.id)
    end
  end
end
