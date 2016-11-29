class Api::V1::Invoices::MerchantsController < ApplicationController
  def show
    render json: Invoice.find(params[:invoice_id]).merchant
  end
end
