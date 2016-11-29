require 'rails_helper'

describe "customers endpoint" do
  context "GET /customers" do
    it "returns all customers" do

      create_list(:customer, 3)

      get "/api/v1/customers.json"

      customers = JSON.parse(response.body)

      expect(response).to be_success
      expect(customers.count).to eq(3)
    end
  end
  context "GET customers/:id" do
    it "returns a customer" do
      customer = create(:customer, first_name: "brad")

      get "/api/v1/customers/#{customer.id}"

      customer = JSON.parse(response.body)

      expect(response).to be_success
      expect(customer["first_name"]).to eq("brad")
    end
  end
end
