class BrandsController < ApplicationController

  def index
    @brands = Brand.all
  end

  def show
    @items = Item.page(params[:page]).where(brand_id: params[:id]).per(122).order('updated_at DESC')
    @brand = Brand.find(params[:id])
  end

end
