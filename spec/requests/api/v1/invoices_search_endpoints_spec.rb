require 'rails_helper'

describe "invoices search endpoint" do
  context "GET /invoices/find?id" do
    it "returns invoice with id" do

      invoice = create(:invoice)
      invoice2 = create(:invoice)

      get "/api/v1/invoices/find?id=#{invoice.id}"

      invoice_response = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice['id']).to eq(invoice.id)
    end
  end

  context "GET /invoices/find?customer_id" do
    it "returns invoice with customer_id" do
      customer = create(:customer)
      invoice = create(:invoice, customer: customer)

      get "/api/v1/invoices/find?customer_id=#{customer.id}"

      invoice_response = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice['customer_id']).to eq(customer.id)
    end
  end

  context "GET /invoices/find?merchant_id" do
    it "returns invoice with merchant_id" do
      merchant = create(:merchant)
      invoice = create(:invoice, merchant: merchant)

      get "/api/v1/invoices/find?merchant_id=#{merchant.id}"

      invoice_response = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice['merchant_id']).to eq(merchant.id)
    end
  end

  context "GET /invoices/find?status" do
    it "returns invoice with status" do
      invoice = create(:invoice, status: 'paid')
      invoice2 = create(:invoice, status: 'unpaid')
      
      get "/api/v1/invoices/find?status=paid"

      invoice_response = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice['status']).to eq('paid')
    end
  end

  context "GET /invoices/find_all?status" do
    it "returns invoices with status paid" do
      invoice = create(:invoice, status: 'paid')
      invoice2 = create(:invoice, status: 'paid')
      invoice3 = create(:invoice, status: 'unpaid')
      
      get "/api/v1/invoices/find_all?status=paid"

      invoices = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoices.count).to eq(2)
      expect(invoices.first['status']).to eq('paid')
      expect(invoices.last['status']).to eq('paid')
    end
  end

  context "GET /invoices/random" do
    it "returns random invoice" do
      invoice = create(:invoice)
      invoice2 = create(:invoice)
      invoice3 = create(:invoice)
      
      get "/api/v1/invoices/random"

      invoice_response = JSON.parse(response.body)

      invoice_ids = [invoice.id, invoice2.id, invoice3.id]
      expect(response).to be_success
      expect(invoice_ids).to include(invoice_response.first['id'])
    end
  end
end