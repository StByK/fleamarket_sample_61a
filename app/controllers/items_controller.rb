class ItemsController < ApplicationController
  
  def index
    @Items = Item.page(125)
  end

end
