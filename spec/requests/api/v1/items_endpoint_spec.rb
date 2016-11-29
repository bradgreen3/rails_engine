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
end