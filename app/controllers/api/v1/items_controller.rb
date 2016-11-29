class Api::V1::ItemsController < ApplicationController

  def index
    render json: Items.all
  end

  def show
    render json: Items.find(params[:id])
  end

end