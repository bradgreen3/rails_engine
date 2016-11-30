class Api::V1::Items::SearchController < ApplicationController
  before_action :change_unit_price
  
  def show
    render json: Item.find_by(search_params)
  end

  def index
    render json: Item.where(search_params)
  end

  private
    def search_params
      params.permit(:id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at)
    end

    def change_unit_price
      params[:unit_price] = params[:unit_price].gsub('.', '') if params[:unit_price]
    end
end