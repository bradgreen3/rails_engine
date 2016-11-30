class Api::V1::Customers::RandomController < ApplicationController
  def show
    render json: Customer.order("RANDOM()").limit(1)
  end
end
