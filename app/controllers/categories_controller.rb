class CategoriesController < ApplicationController
  before_action :set_category

  def index
    @parents = Category.all.roots
  end

  def show
    @items = Item.all.where(category_id: @category.ids
    )
  end

  private

  def set_category
    categories = Category.all.where(id: params[:id])
    categories.each do |category|
      @category = category.subtree
    end
  end

end