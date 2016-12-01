class Api::V1::Merchants::FavoritesController < ApplicationController
	def show
		render json: Customer.favorite_customer(params[:merchant_id])
	end
end