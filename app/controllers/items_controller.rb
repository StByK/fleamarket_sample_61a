class ItemsController < ApplicationController

  def new
    @item = Item.new

    @category_parent = Category.where(ancestry: nil)

    Category.where(ancestry: nil).each do |parent|      
      @child = parent.children

      parent.children.each do |child|
        @grandchild = child.children
      end
    end

    # @category_parent = ["---"]
    # @child = ["---"]
    # @grandchild = ["---"]
    # Category.where(ancestry: nil).each do |parent|
    #   @category_parent << parent.name
    #   parent.children.each do |child|
    #     @child << child.name
    #     child.children.each do |grandchild|
    #       @grandchild << grandchild.name
    #     end
    #   end 
    # end      

    @brand = Brand.select("name","id")

  end

  def create
    @item = Item.new
  end

  def index
    @Items = Item.page(125)
  end

  private

  def item_params
    params.require(:item).permit(:name,:description,:condition,:shipment_fee,:shipment_method,:shipment_date,
    :prefecture_index,:price,:size,:category_id,:brand_id).merge(seller_id: current_user.id)
  end
  
end