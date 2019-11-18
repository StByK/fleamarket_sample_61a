class PurchaseController < ApplicationController
    require 'payjp'
  
    def index
      if user_signed_in?
        @item = Item.find(params[:item_id])
        @main_image = Image.where(item_id: @item.id).order("id ASC").limit(1)
        card = Card.where(user_id: current_user.id).first
        if card.blank?
          redirect_to controller: "card", action: "new"
        else
          Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
          customer = Payjp::Customer.retrieve(card.customer_id)
          @default_card_information = customer.cards.retrieve(card.card_id)
        end
      else
        redirect_to new_user_registration_path
      end
    end
  
    def pay
      card = Card.where(user_id: current_user.id).first
      Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
      item = Item.find(params[:item_id])
      Payjp::Charge.create(
      amount: item.price,
      customer: card.customer_id, 
      currency: 'jpy', 
    )
    redirect_to action: 'done' 
    end
  
    def done
      @item = Item.find(params[:item_id])
      @dealing = Dealing.find_by(item_id: @item.id)
      @dealing.update(status: 2)

      redirect_to root_path, notice: '商品の購入が完了しました'
    end
end
  

