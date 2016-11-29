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

  context "GET customers/:id/invoices" do
    it "returns a customers invoices" do
      customer = create(:customer, first_name: 'Matt')
      customer.invoices = create_list(:invoice, 3)

      get "/api/v1/customers/#{customer.id}/invoices"

      invoices = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoices.count).to eq(3)
      expect(invoices.first['customer_id']).to eq(customer.id)
      expect(invoices.last['customer_id']).to eq(customer.id)
    end
  end

    context "GET customers/:id/transactions" do
    it "returns a customers transactions" do
      customer = create(:customer, first_name: 'Matt')
      invoice = create(:invoice, customer: customer)
      invoice2 = create(:invoice)
      create(:transaction, invoice: invoice)
      create(:transaction, invoice: invoice)
      create(:transaction, invoice: invoice2)

      get "/api/v1/customers/#{customer.id}/transactions"

      transactions = JSON.parse(response.body)

      invoice_response = Invoice.find(transactions.last['invoice_id'])

      expect(response).to be_success
      expect(transactions.count).to eq(2)
      expect(transactions.first['invoice_id']).to eq(invoice.id)
      expect(invoice_response.customer_id).to eq(customer.id)
    end
  end
end
