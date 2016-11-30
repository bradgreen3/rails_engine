class Api::V1::InvoiceItems::SearchController < ApplicationController
  before_action :change_unit_price

  def show
    change_unit_price if params[:unit_price]
    render json: InvoiceItem.find_by(search_params)
  end

  def index
    change_unit_price if params[:unit_price]
    render json: InvoiceItem.where(search_params)
  end

  private
    def search_params
      params.permit(:id, :invoice_id, :item_id, :quantity, :unit_price, :created_at, :updated_at)
    end

    def change_unit_price
      params[:unit_price] = params[:unit_price].gsub('.', '') if params[:unit_price]
    end
end