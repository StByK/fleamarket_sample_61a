class CategoriesController < ApplicationController
  before_action :set_category

  def index
    @parents = Category.all.roots
  end

  def show
    @items = Item.where(category_id:  params[:id])
    @items = Item.page(params[:page]).per(25).order('updated_at DESC')
  end

  private

  def set_category
    categories = Category.all.where(id: params[:id])
    categories.each do |category|
      @category = category.subtree
    end
  end

end