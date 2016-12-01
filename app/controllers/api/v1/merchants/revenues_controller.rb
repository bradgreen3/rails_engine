class Api::V1::Merchants::RevenuesController < ApplicationController
	def show
		render json: Merchant.find(params[:merchant_id]).total_revenue(params[:date])
	end
end
