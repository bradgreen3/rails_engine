require 'rails_helper'

describe "items search endpoint" do
  context "GET /items/find?id" do
    it "returns item with id" do

      item = create(:item)
      item2 = create(:item)

      get "/api/v1/items/find?id=#{item.id}"

      item_response = JSON.parse(response.body)

      expect(response).to be_success
      expect(item_response['id']).to eq(item.id)
    end
  end

  context "GET /items/find?description" do
    it "returns item with case insensitive search" do

      item = create(:item, description: "cool")
      item2 = create(:item, description: "not cool")

      get "/api/v1/items/find?description=COoL"

      item_response = JSON.parse(response.body)

      expect(response).to be_success
      expect(item_response['description']).to eq("cool")
    end
  end

  context "GET /items/find?name" do
    it "returns item with name" do
      item = create(:item, name: "Bob")

      get "/api/v1/items/find?name=#{item.name}"

      item_response = JSON.parse(response.body)

      expect(response).to be_success
      expect(item_response['name']).to eq("Bob")
    end
  end

  context "GET /items/find?unit_price" do
    it "returns item with unit_price" do
      item = create(:item, unit_price: 199)

      get "/api/v1/items/find?unit_price=1.99"

      item_response = JSON.parse(response.body)

      expect(response).to be_success
      expect(item_response['unit_price']).to eq("1.99")
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

  context "GET /invoices/find_all?unit_price" do
    it "returns invoices with unit_price" do
      item = create(:item, unit_price: 199)
      item2 = create(:item, unit_price: 199)
      item3 = create(:item, unit_price: 299)

      get "/api/v1/items/find_all?unit_price=1.99"

      invoices = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoices.count).to eq(2)
      expect(invoices.first['unit_price']).to eq('1.99')
      expect(invoices.last['unit_price']).to eq('1.99')
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
