class BrandsController < ApplicationController

  def index
    @brands = Brand.all
  end

  def show
    @items = Item.page.where(brand_id: params[:id]).per(125)
  end

end
