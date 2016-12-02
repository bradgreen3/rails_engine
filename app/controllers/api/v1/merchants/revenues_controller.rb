class Api::V1::Merchants::RevenuesController < ApplicationController
	def show
		render json: Merchant.find(params[:merchant_id]).total_revenue(params[:date]), serializer: RevenueSerializer
	end

	def index
		render json: Merchant.top_merchants_list(params[:quantity])
	end
end
