class ItemsController < ApplicationController

  # before_action :move_to_items_index, except: [:index,:show]


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
    @item = 
    @item = Item.create!(item_params)
    @image = @item.images.build
    if @item.save
      params[:images][:image].each do |i|
        @item.images.create(image: i, item_id: @item.id)
      end
      redirect_to root_path, notice: '出品しました。'
    else
      render :new
      # format.html{render action: 'new'}
    end
  
  end
  
  before_action :sort_items

  def show
  end

  def index
    category_1st = Category.all.find(1).descendant_ids
    category_2nd = Category.all.find(214).descendant_ids
    category_3rd = Category.all.find(978).descendant_ids
    category_4th = Category.all.find(743).descendant_ids

    @category_1st_items = @items.where(category_id: category_1st).first(10)
    @category_2nd_items = @items.where(category_id: category_2nd).first(10)
    @category_3rd_items = @items.where(category_id: category_3rd).first(10)
    @category_4th_items = @items.where(category_id: category_4th).first(10)

    @brand_1st = Item.all.where(brand_id: 2446).first(10)
    @brand_2nd = Item.all.where(brand_id: 6165).first(10)
    @brand_3rd = Item.all.where(brand_id: 6781).first(10)
    @brand_4th = Item.all.where(brand_id: 3815).first(10)

  end

  private

  def item_params
    params.require(:item).permit(:name,:description,:condition,:shipment_fee,:shipment_method,:shipment_date,
    :prefecture_index,:price,:size,:category_id,images_attributes: [:image])
  end
  
  def sort_items
    @items = Item.all.order(created_at: "ASC")
  end

  # def move_to_items_index
  #   redirect_to root_path unless user_signed_in?
  # end

end