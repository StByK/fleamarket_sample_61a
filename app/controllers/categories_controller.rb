class CategoriesController < ApplicationController

  def show
    @items = Item.all.where(category_id == params[:id])
  end

end