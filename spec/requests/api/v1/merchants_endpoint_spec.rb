require 'rails_helper'

describe "merchants endpoint" do
  context "GET /merchants" do
    it "returns all merchants" do
      create_list(:merchant, 3)

      get "/api/v1/merchants.json"

      merchants = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchants.count).to eq(3)
    end
  end
  context "GET /merchants/:id" do
    it "returns a merchant" do
      merchant = create(:merchant, name: "Reynolds Inc")

      get "/api/v1/merchants/#{merchant.id}"

      merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant["name"]).to eq("Reynolds Inc")
    end
  end
end
