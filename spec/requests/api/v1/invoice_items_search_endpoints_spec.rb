require 'rails_helper'

describe "invoice_items search endpoint" do
  context "GET /invoice_items/find?id" do
    it "returns invoice_items with id" do

      invoice_item = create(:invoice_item)
      invoice_item2 = create(:invoice_item)

      get "/api/v1/invoice_items/find?id=#{invoice_item.id}"

      invoice_item_response = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_item['id']).to eq(invoice_item.id)
    end
  end

  context "GET /invoice_items/find?quantity" do
    it "returns invoice_items with quantity" do
      invoice_item = create(:invoice_item, quantity: 99)
      invoice_item2 = create(:invoice_item, quantity: 100)

      get "/api/v1/invoice_items/find?quantity=99"

      invoice_items_response = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_items_response['quantity']).to eq(99)
    end
  end

  context "GET /invoice_items/find?unit_price" do
    it "returns invoice_item with unit_price" do
      invoice_item = create(:invoice_item, unit_price: 199)
      invoice_item2 = create(:invoice_item, unit_price: 299)

      get "/api/v1/invoice_items/find?unit_price=199"

      invoice_item_response = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_item_response['unit_price']).to eq(199)
    end
  end

  context "GET /invoice_items/find_all?name" do
    it "returns invoice_items with status paid" do
      invoice_items = create(:invoice_item, quantity: 99)
      invoice_items2 = create(:invoice_item, quantity: 99)
      invoice_items3 = create(:invoice_item, quantity: 100)
      
      get "/api/v1/invoice_items/find_all?quantity=99"

      invoice_items = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_items.count).to eq(2)
      expect(invoice_items.first['quantity']).to eq(99)
      expect(invoice_items.last['quantity']).to eq(99)
    end
  end

  context "GET /invoice_items/random" do
    it "returns random invoice_item" do
      invoice_item = create(:invoice_item)
      invoice_item2 = create(:invoice_item)
      invoice_item3 = create(:invoice_item)
      
      get "/api/v1/invoice_items/random"

      invoice_item_response = JSON.parse(response.body)

      invoice_item_ids = [invoice_item.id, invoice_item2.id, invoice_item3.id]
      expect(response).to be_success
      expect(invoice_item_ids).to include(invoice_item_response.first['id'])
    end
  end
end