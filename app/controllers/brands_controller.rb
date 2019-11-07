class BrandsController < ApplicationController
  def show
    @items = Item.all.where(brand_id == params[:id])
  end
end
