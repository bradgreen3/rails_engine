class Api::V1::InvoiceItems::RandomController < ApplicationController
  def show
    render json: InvoiceItem.order('RANDOM()').limit(1)
  end
end
