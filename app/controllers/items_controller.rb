class ItemsController < ApplicationController
  def sell
    # @item = Item.new(seller_id: current_user.id)
  end

  def index
    @Items = Item.page(125)
  end
end