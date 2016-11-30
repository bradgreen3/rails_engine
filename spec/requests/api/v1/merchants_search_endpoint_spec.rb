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
end
