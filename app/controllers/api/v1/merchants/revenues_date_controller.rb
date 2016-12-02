class Api::V1::Merchants::RevenuesDateController < ApplicationController
	def show
		render json: Merchant.total_merchants_revenue_by_date(params[:date]), serializer: TotalRevenueSerializer 
	end
end