require 'rails_helper'

describe "invoice_items endpoint" do
  context "GET /invoice_items" do
    it "returns all invoice_items" do

      create_list(:invoice_item, 3)

      get "/api/v1/invoice_items.json"

      invoice_items = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_items.count).to eq(3)
    end
  end
  context "GET invoice_items/:id" do
    it "returns a invoice_item" do
      invoice_item = create(:invoice_item, quantity: 99)

      get "/api/v1/invoice_items/#{invoice_item.id}"

      invoice_item = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_item["quantity"]).to eq(99)
    end
  end
end
