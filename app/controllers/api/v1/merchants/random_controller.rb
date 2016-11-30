class Api::V1::Merchants::RandomController < ApplicationController
  def show
    render json: Merchant.order("RANDOM()").limit(1)
  end
end
