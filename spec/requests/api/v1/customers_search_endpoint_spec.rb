require 'rails_helper'

describe "customers search endpoint" do
  context "GET /api/v1/customers/find?id=1" do
    it "returns customer with id from params" do

      customer1 = create(:customer)
      customer2 = create(:customer)

      get "/api/v1/customers/find?id=#{customer1.id}"

      customer_response = JSON.parse(response.body)

      expect(response).to be_success
      expect(customer_response["id"]).to eq(customer1.id)

    end
  end
  context "GET /api/v1/customers/find?name=bRaD" do
    it "returns customer from case insensitive params" do

      customer1 = create(:customer, first_name: "matt")
      customer2 = create(:customer, first_name: "brad")

      get "/api/v1/customers/find?first_name=BRAD"

      customer_response = JSON.parse(response.body)

      expect(response).to be_success
      expect(customer_response["first_name"]).to eq("brad")
    end
  end
  context "GET /customers/find_all?parameters" do
    it "returns all customers with same first_name" do
      customer1 = create(:customer, first_name: "brad")
      customer2 = create(:customer, first_name: "brad")
      customer3 = create(:customer, first_name: "matt")

      get "/api/v1/customers/find_all?first_name=brad"

      customers = JSON.parse(response.body)

      expect(response).to be_success
      expect(customers.count).to eq(2)
    end
  end
  context "GET /api/v1/customers/random" do
    it "returns a random customer" do

      customer1 = create(:customer)
      customer2 = create(:customer)
      customer3 = create(:customer)

      get "/api/v1/customers/random"

      customer_response = JSON.parse(response.body)
      customer_ids = [customer1.id, customer2.id, customer3.id]

      expect(response).to be_success
      expect(customer_ids).to include(customer_response[0]["id"])
    end
  end
end
