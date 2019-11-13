class CardController < ApplicationController

  require "payjp"

  def new
    card = current_user.cards
    redirect_to action: "show" if card.exists?
  end
  
  
  def create
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    if params['payjp_token'].blank?
      redirect_to action: "new", id: current_user.id
    else
      customer = Payjp::Customer.create(
      card: params['payjp_token'],
      metadata: {user_id: current_user.id}
      ) 
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to action: "show"
      else
        redirect_to action: "create"
      end
    end
  end
  
  def delete #PayjpとCardデータベースを削除します
    card = current_user.cards.first

      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(card.customer_id)
      customer.delete
      card.delete

      redirect_to action: "new"
  end

  def show #Cardのデータpayjpに送り情報を取り出します
    card = current_user.cards.first
    if card.blank?
      redirect_to action: "new" 
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(card.customer_id)
      @default_card_information = customer.cards.retrieve(card.card_id)
    end
  end

  def confirmation
    card = current_user.cards
    redirect_to action: "show" if card.exists?
  end   
end
