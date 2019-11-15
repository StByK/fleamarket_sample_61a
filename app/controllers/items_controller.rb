
class ItemsController < ApplicationController

  before_action :move_to_items_index, except: [:index,:show]


  def new

    @item = Item.new
    @image = @item.images.build

    @parent = Category.where(ancestry: nil)
    @child = Category.c_category(@parent)
    @grandchild = Category.c_category(@child)

    @brand = Brand.select("name","id")
  end

  def create

    @parent = Category.where(ancestry: nil)
    @child = Category.c_category(@parent)
    @grandchild = Category.c_category(@child)

    @brand = Brand.select("name","id")

    @item = Item.new(item_params)
    if @item.save
      params[:images]['image'].each do |i|
        @image = @item.images.create!(image: i, item_id: @item.id)
      end
      Dealing.create!(item_id:@item.id,seller_id:current_user.id)
      # binding.pry
        redirect_to root_path
      else
        render :new
    end


  end
  
  before_action :sort_items
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

  def show
    @item = Item.find(params[:id])
    @seller = User.find(@item.seller_id)
    category_check(@item.category)
    @prefecture = Prefecture.find(@item.prefecture_index)
    @previous_item = @item.previous
    @next_item = @item.next
    @user_items = Item.where(seller_id: @item.seller_id).order("id DESC").limit(6)
    @category_items = Item.where(category_id: @item.category_id).where.not(id: @item.id).order("id DESC").limit(6)
    @main_image = Image.where(item_id: @item.id).order("id ASC").limit(1)
    @sub_image = Image.where(item_id: @item.id).order("id ASC").limit(10)
  end

  def category_check(category)
    ancestry = category.ancestry
    parent = ancestry.match(/^\d+/)[0].to_i
    child = ancestry.match(/\d+$/)[0].to_i
    @category_parent = Category.find(parent)
    @category_child = Category.find(child)
    @category_grand_child = Category.find(category.id)
  end

  private

  def item_params
    params.require(:item).permit(:name,:description,:condition,:shipment_fee,:shipment_method,:shipment_date,:prefecture_index,:price,:size,:brand_id,:category_id,images_attributes: [:image,:item_id]).merge(seller_id: current_user.id)
  end

  def sort_items
    @items = Item.all.order(created_at: "ASC")
  end

  def move_to_items_index
    redirect_to root_path unless user_signed_in?
  end

end