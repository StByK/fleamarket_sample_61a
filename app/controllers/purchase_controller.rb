class PurchaseController < ApplicationController
  before_action :check_user_id, if: :user_signed_in?
  before_action :soldout_item
  before_action :set_item

  require 'payjp'
  
  def index
    if user_signed_in?
      @item_image = Image.find_by(item_id: @item.id)
      card = Card.where(user_id: current_user.id).first
      if card.blank?
        redirect_to controller: "card", action: "new"
      else
        Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
        customer = Payjp::Customer.retrieve(card.customer_id)
        @default_card_information = customer.cards.retrieve(card.card_id)
      end
    else
      redirect_to new_user_session_path, alert: 'ログインしてください'
    end
  end
  
  def pay
    card = Card.where(user_id: current_user.id).first
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      customer: card.customer_id,
      currency: 'jpy',
    )
    redirect_to action: 'done' 
  end
  
  def done
    @dealing = Dealing.find_by(item_id: @item.id)
    @dealing.update(status: 3)
    redirect_to root_path, notice: '商品の購入が完了しました'
  end


  private
  def set_item
    @item = Item.find(params[:item_id])
  end

  def check_user_id
    if Item.find(params[:item_id]).seller_id == current_user.id
      flash[:alert] = "自分が出品した商品は購入できません"
      redirect_to root_path
    end
  end

  def soldout_item
    @item = Item.find(params[:item_id])
    @dealing = Dealing.find_by(item_id: @item.id)
      if @dealing.status == 3
        flash[:alert] = "この商品は購入済みです"
        redirect_to root_path
      end    
  end
end
  

