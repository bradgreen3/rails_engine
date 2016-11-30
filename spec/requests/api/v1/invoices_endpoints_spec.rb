require 'rails_helper'

describe "invoices endpoint" do
  context "GET /invoices" do
    it "returns all invoices" do
      create_list(:invoice, 3)

      get "/api/v1/invoices.json"

      invoices = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoices.count).to eq(3)
    end
  end
  context "GET /invoices/:id" do
    it "returns a invoice" do
      invoice = create(:invoice, status: "Is Paid")

      get "/api/v1/invoices/#{invoice.id}"

      invoice = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice["status"]).to eq("Is Paid")
    end
  end

  context "GET /invoices/:id/transactions" do
    it "returns a invoices transactions" do
      invoice = create(:invoice)
      invoice.transactions = create_list(:transaction, 3)

      get "/api/v1/invoices/#{invoice.id}/transactions"

      transactions = JSON.parse(response.body)

      expect(response).to be_success
      expect(transactions.count).to eq(3)
      expect(transactions.first["invoice_id"]).to eq(invoice.id)
    end
  end

  context "GET /invoices/:id/invoice_items" do
    it "returns a invoices invoice_items" do
      invoice = create(:invoice)
      invoice.invoice_items = create_list(:invoice_item, 3)

      get "/api/v1/invoices/#{invoice.id}/invoice_items"

      invoice_items = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_items.count).to eq(3)
      expect(invoice_items.first["invoice_id"]).to eq(invoice.id)
    end
  end

  context "GET /invoices/:id/items" do
    it "returns a invoices items" do
      invoice = create(:invoice)
      invoice2 = create(:invoice)
      item1 = create(:item)
      item2 = create(:item)
      create(:invoice_item, invoice: invoice, item: item1)
      create(:invoice_item, invoice: invoice, item: item1)
      create(:invoice_item, invoice: invoice2, item: item2)

      get "/api/v1/invoices/#{invoice.id}/items"

      items = JSON.parse(response.body)

      invoice_item_record = InvoiceItem.find_by(item_id: items.last['id'])

      expect(response).to be_success
      expect(items.count).to eq(2)
      expect(invoice_item_record.invoice_id).to eq(invoice.id)
    end
  end
end
