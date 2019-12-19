class ItemsController < ApplicationController
  # before_action :authenticate_user!, except: [:index, :show]
  before_action :sort_items, onry: :index
  before_action :set_item, except: [:index, :new, :create]
  before_action :set_category_and_brand, onry: [:edit, :update]

  def new
    @item = Item.new
    @image = @item.images.build
    @images = Image.where(item_id: @item.id)
  end

  def create
    @item = Item.new(item_params)
    if @item.save && params[:images].present?
      params[:images]['image'].each do |i|
        @image = @item.images.create!(image: i, item_id: @item.id)
      end
      Dealing.create!(item_id:@item.id,seller_id:current_user.id)
      redirect_to root_path, notice: "商品を出品しました"
    else
      redirect_to new_item_path, alert: "入力情報に不備があります"
    end
  end

  def index
    category_1st = Category.all.find(1).descendant_ids
    category_2nd = Category.all.find(214).descendant_ids
    category_3rd = Category.all.find(978).descendant_ids
    category_4th = Category.all.find(743).descendant_ids

    @category_1st_items = @items.where(category_id: category_1st).order("created_at DESC").limit(10)
    @category_2nd_items = @items.where(category_id: category_2nd).order("created_at DESC").limit(10)
    @category_3rd_items = @items.where(category_id: category_3rd).order("created_at DESC").limit(10)
    @category_4th_items = @items.where(category_id: category_4th).order("created_at DESC").limit(10)

    @brand_1st = Item.all.where(brand_id: 2446).order("created_at DESC").limit(10)
    @brand_2nd = Item.all.where(brand_id: 6165).order("created_at DESC").limit(10)
    @brand_3rd = Item.all.where(brand_id: 6781).order("created_at DESC").limit(10)
    @brand_4th = Item.all.where(brand_id: 3815).order("created_at DESC").limit(10)
  end

  def show
    @item_image = Image.where(item_id: @item.id).order("id ASC").limit(10)
    @seller = User.find(@item.seller_id)
    category_check(@item.category)
    @prefecture = Prefecture.find(@item.prefecture_index)
    @user_items = Item.where(seller_id: @item.seller_id).order("id DESC").where.not(id: @item.id).limit(6)
    image_first = Image.group(:item_id).pluck(:id)
    @user_image = Image.where(id: image_first).where(item_id: @user_items.ids).where.not(id: @item.id).order("item_id DESC").limit(6)
    @category_items = Item.where(category_id: @item.category_id).where.not(id: @item.id).order("id DESC").limit(6)
    @category_image = Image.where(id: image_first).where(item_id: @category_items.ids).where.not(id: @item.id).order("item_id DESC").limit(6)

    if current_user == @seller
      redirect_to show2_item_path
    end
  end

  def show2
    if @item.seller_id == current_user.id
      @item_image = Image.where(item_id: @item.id).order("id ASC").limit(10)
      @seller = User.find(@item.seller_id)
      category_check(@item.category)
      @prefecture = Prefecture.find(@item.prefecture_index)
    else
      redirect_to root_path
    end
  end

  def edit
    if @item.seller_id == current_user.id
      @images = Image.where(item_id: params[:id])
    else
      redirect_to root_path
    end
  end

  def update
    if @item.seller_id == current_user.id && @item.update(item_params) && params[:images].present?
      Image.where(item_id: params[:id]).delete_all
      params[:images]['image'].each do |i|
        @image = @item.images.create(image: i, item_id: @item.id)
      end
      redirect_to root_path, notice: "商品の情報を更新しました"
    else
      flash[:alert] = "入力情報に不備があります"
      render action: :edit
    end
  end

  def destroy
    if @item.seller_id == current_user.id
      @item.destroy
      redirect_to root_path, alert: "商品を削除しました"
    else
      render :show
    end 
  end  

private

  def item_params
    params.require(:item).permit(:name,:description,:condition,:shipment_fee,:shipment_method,:shipment_date,:prefecture_index,:price,:size,:brand_id,:category_id,images_attributes: [:id, :image,:item_id]).merge(seller_id: current_user.id)
  end

  def sort_items
    @items = Item.all.order(created_at: "ASC")
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def category_check(category)
    ancestry = category.ancestry
    parent = ancestry.match(/^\d+/)[0].to_i
    child = ancestry.match(/\d+$/)[0].to_i
    @category_parent = Category.find(parent)
    @category_child = Category.find(child)
    @category_grand_child = Category.find(category.id)
  end

  def set_category_and_brand
    @parent = Category.where(ancestry: nil)
    @child = Category.c_category(@parent)
    @grandchild = Category.c_category(@child)
    @brand = Brand.select("name","id")
  end
end