class ItemsController < ApplicationController

  def new
    @item = Item.new
    @image = @item.images.build

    @parent = Category.where(ancestry: nil)
    @child = []
    @grandchild = []
    @parent.each do |parent|
      parent.children.each do |child|
        @child << child
        child.children.each do |grandchild|
          @grandchild << grandchild
        end
      end
    end

    # @category_parent = Category.where(ancestry: nil)

    # Category.where(ancestry: nil).each do |parent|      
    #   @child = parent.children

    #   parent.children.each do |child|
    #     @grandchild = child.children
    #   end
    # end

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
    @parent = Category.where(ancestry: nil)
    @child = []
    @grandchild = []
    @parent.each do |parent|
      parent.children.each do |child|
        @child << child
        child.children.each do |grandchild|
          @grandchild << grandchild
        end
      end
    end

    @brand = Brand.select("name","id")
    @item = Item.create!(item_params)
    @image = @item.images.build
    # if @item.save
    #   params[:images][:image].each do |i|
    #     @item.images.create(image: i, item_id: @item.id)
    #   end
    #   redirect_to root_path, notice: '出品しました。'
    # else
    #   render :new
    #   # format.html{render action: 'new'}
    # end
    redirect_to new_item_path 
  end

  def index
    @Items = Item.page(125)
  end

  private

  def item_params
    params.require(:item).permit(:name,:description,:condition,:shipment_fee,:shipment_method,:shipment_date,
    :prefecture_index,:price,:size,:category_id,:brand_id,images_attributes: [:image])
  end
  
end