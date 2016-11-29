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
end
