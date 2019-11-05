class ItemsController < ApplicationController
  def sell
  end

  def index
    @Items = Item.page(125)
  end
end