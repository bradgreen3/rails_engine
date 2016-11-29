require 'rails_helper'

describe "items endpoint" do
  context "GET /items" do
    it "returns all items" do
      create_list(:item, 3)

      get "/api/v1/items.json"

      items = JSON.parse(response.body)

      expect(response).to be_success
      expect(items.count).to eq(3)
    end
  end
  context "GET /items/:id" do
    it "returns a item" do
      item = create(:item, name: "Stuff")

      get "/api/v1/items/#{item.id}"

      item = JSON.parse(response.body)

      expect(response).to be_success
      expect(item["name"]).to eq("Stuff")
    end
  end
  context "GET /items/:id/invoice_items" do
    it "returns associated invoice items" do
      item = create(:item, name: "Stuff")
      item.invoice_items = create_list(:invoice_item, 3)

      get "/api/v1/items/#{item.id}/invoice_items.json"

      invoice_items = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_items.count).to eq(3)
      expect(invoice_items.first["item_id"]).to eq(item.id)
      expect(invoice_items.last["item_id"]).to eq(item.id)
    end
  end
  context "GET /api/v1/items/:id/merchant.json" do
    it "returns associated merchant" do
      merchant = create(:merchant, name: "Target")
      item = create(:item, merchant: merchant)

      get "/api/v1/items/#{item.id}/merchant.json"

      merchant_response = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant_response["id"]).to eq(merchant.id)
      expect(merchant_response["name"]).to eq("Target")
    end
  end
end
