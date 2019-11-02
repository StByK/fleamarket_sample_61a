class ItemsController < ApplicationController
  def sell
  end
end
  def index
    @Items = Item.page(125)
  end
end