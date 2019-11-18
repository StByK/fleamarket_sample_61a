class CategoriesController < ApplicationController
  before_action :set_category

  def index
    @parents = Category.all.roots
  end

  def show
    category_id = Category.find(params[:id]).subtree
    @items = Item.page(params[:page]).where(category_id: category_id).per(122).order('updated_at DESC')
    @category = Category.find(params[:id])
  end

  private

  def set_category
    categories = Category.all.where(id: params[:id])
    categories.each do |category|
      @category = category.subtree
    end
  end

end