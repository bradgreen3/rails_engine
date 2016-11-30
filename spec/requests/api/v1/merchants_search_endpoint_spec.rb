require 'rails_helper'

describe "merchants search endpoint" do
  context "GET /api/v1/merchants/find?id=1" do
    it "returns merchant with id" do

      merchant1 = create(:merchant)
      merchant2 = create(:merchant)

      get "/api/v1/merchants/find?id=#{merchant1.id}"

      merchant_response = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant_response["id"]).to eq(merchant1.id)

    end
  end

  context "GET /api/v1/merchants/find?name" do
    it "returns merchant with name" do

      merchant1 = create(:merchant, name: 'Brad')
      merchant2 = create(:merchant)

      get "/api/v1/merchants/find?name=#{merchant1.name}"

      merchant_response = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant_response["name"]).to eq('Brad')
    end
  end
  context "GET /merchants/find_all?parameters" do
    it "returns all merchants with same name" do
      merchant1 = create(:merchant, name: "brad")
      merchant2 = create(:merchant, name: "brad")
      merchant3 = create(:merchant, name: "matt")

      get "/api/v1/merchants/find_all?name=brad"

      merchants = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchants.count).to eq(2)
    end
  end
  context "GET /api/v1/merchants/random" do
    it "returns a random merchant" do

      merchant1 = create(:merchant)
      merchant2 = create(:merchant)
      merchant3 = create(:merchant)

      get "/api/v1/merchants/random"

      merchant_response = JSON.parse(response.body)
      merchant_ids = [merchant1.id, merchant2.id, merchant3.id]

      expect(response).to be_success
      expect(merchant_ids).to include(merchant_response[0]["id"])
    end
  end
end
