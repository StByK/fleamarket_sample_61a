class ItemsController < ApplicationController
  def show
  end

  def index
    @Items = Item.page(125)
  end

  private


end