require 'rails_helper'

describe "merchants endpoint" do
  context "GET /merchants" do
    it "returns all merchants" do
      create_list(:merchant, 3)

      get "/api/v1/merchants"

      merchants = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchants.count).to eq(3)
    end
  end
  context "GET /merchants/:id" do
    it "returns a merchant" do
      merchant = create(:merchant, name: "Reynolds Inc")

      get "/api/v1/merchants/#{merchant.id}"

      merchant_response = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant["name"]).to eq("Reynolds Inc")
      expect(merchant_response["created_at"]).to eq(nil)
      expect(merchant_response["updated_at"]).to eq(nil)
    end
  end

  context "GET /merchants/:id/items" do
    it "returns a merchants items" do
      merchant = create(:merchant, name: 'Matt')
      merchant.items = create_list(:item, 3)

      get "/api/v1/merchants/#{merchant.id}/items"

      items = JSON.parse(response.body)

      expect(response).to be_success
      expect(items.count).to eq(3)
      expect(items.first['merchant_id']).to eq(merchant.id)
      expect(items.last['merchant_id']).to eq(merchant.id)
    end
  end

  context "GET /merchants/:id/invoices" do
      it "returns a merchants invoices" do
      merchant = create(:merchant, name: 'Matt')
      merchant.invoices = create_list(:invoice, 3)

      get "/api/v1/merchants/#{merchant.id}/invoices"

      invoices = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoices.count).to eq(3)
      expect(invoices.first['merchant_id']).to eq(merchant.id)
      expect(invoices.last['merchant_id']).to eq(merchant.id)
    end
  end
end
