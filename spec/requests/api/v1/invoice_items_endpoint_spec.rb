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

  context "GET /invoice_items/:id/invoice" do
    it "returns associated invoice" do
      invoice = create(:invoice, status: "complete")
      invoice_item = create(:invoice_item, invoice: invoice)

      get "/api/v1/invoice_items/#{invoice_item.id}/invoice"

      invoice_response = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_response["id"]).to eq(invoice.id)
      expect(invoice_response["status"]).to eq("complete")
    end
  end

  context "GET /invoice_items/:id/item" do
    it "returns associated item" do
      item = create(:item, name: "thing")
      invoice_item = create(:invoice_item, item: item)

      get "/api/v1/invoice_items/#{invoice_item.id}/item"

      item_response = JSON.parse(response.body)

      expect(response).to be_success
      expect(item_response["id"]).to eq(item.id)
      expect(item_response["name"]).to eq("thing")
    end
  end
end
