class BrandsController < ApplicationController

  def index
    @brands = Brand.all
  end

  def show
    @items = Item.all.where(brand_id == params[:id])
  end

end
