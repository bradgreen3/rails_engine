require 'rails_helper'

describe "items search endpoint" do
  context "GET /items/find?id" do
    it "returns item with id" do

      item = create(:item)
      item2 = create(:item)

      get "/api/v1/items/find?id=#{item.id}"

      item_response = JSON.parse(response.body)

      expect(response).to be_success
      expect(item['id']).to eq(item.id)
    end
  end

  context "GET /items/find?name" do
    it "returns item with name" do
      item = create(:item, name: "Bob")

      get "/api/v1/items/find?name=#{item.name}"

      item_response = JSON.parse(response.body)

      expect(response).to be_success
      expect(item['name']).to eq(item.name)
    end
  end

  context "GET /items/find?description" do
    it "returns item with description" do
      item = create(:item, description: "description")

      get "/api/v1/items/find?description=description"

      invoice_response = JSON.parse(response.body)

      expect(response).to be_success
      expect(item['description']).to eq(item.description)
    end
  end

  context "GET /invoices/find_all?name" do
    it "returns invoices with status paid" do
      item = create(:item, name: 'bob')
      item2 = create(:item, name: 'bob')
      item3 = create(:item, name: 'sally')
      
      get "/api/v1/items/find_all?name=bob"

      invoices = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoices.count).to eq(2)
      expect(invoices.first['name']).to eq('bob')
      expect(invoices.last['name']).to eq('bob')
    end
  end

  context "GET /items/random" do
    it "returns random item" do
      item = create(:item)
      item2 = create(:item)
      item3 = create(:item)
      
      get "/api/v1/items/random"

      item_response = JSON.parse(response.body)

      item_ids = [item.id, item2.id, item3.id]
      expect(response).to be_success
      expect(item_ids).to include(item_response.first['id'])
    end
  end
end