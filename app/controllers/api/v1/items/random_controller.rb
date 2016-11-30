class Api::V1::Items::RandomController < ApplicationController
  def show
    render json: Item.order("RANDOM()").limit(1)
  end
end