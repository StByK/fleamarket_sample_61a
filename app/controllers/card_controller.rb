class CardController < ApplicationController
  before_action :set_card, only: [:new,:confirmation]
  before_action :set_card_first, only: [:delete,:show]


  require "payjp"

  def new
    redirect_to action: "show" if @card.exists?
  end
  
  
  def create
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    if params['payjp_token'].blank?
      redirect_to action: "new", id: current_user.id and return
    else
      customer = Payjp::Customer.create(
      card: params['payjp_token'],
      metadata: {user_id: current_user.id}
      ) 
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        path = Rails.application.routes.recognize_path(request.referer)
        if path[:controller] == "card" && path[:action] == "new" 
          redirect_to action: "show" and return
        else
          redirect_to done_signup_index_path and return
        end
        redirect_to action: "show" and return
      else
        redirect_to action: "create" and return
      end
    end
  end
  
  def delete #PayjpとCardデータベースを削除します
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(@card.customer_id)
      customer.delete
      @card.delete

      redirect_to card_path(current_user)
  end

  def show #Cardのデータpayjpに送り情報を取り出します
    if @card.blank?
      redirect_to action: "new" 
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @default_card_information = customer.cards.retrieve(@card.card_id)
    end
    @card_brand = @default_card_information.brand      
    case @card_brand
    when "Visa"
      @card_src = "visa.svg"
    when "JCB"
      @card_src = "jcb.svg"
    when "MasterCard"
      @card_src = "master-card.svg"
    when "American Express"
      @card_src = "american_express.svg"
    when "Diners Club"
      @card_src = "dinersclub.svg"
    when "Discover"
      @card_src = "discover.svg"
    when "Saison"
      @card_src = "saison-card.svg"
    end
  end

  def confirmation
    redirect_to action: "show" if @card.exists?
  end


  private
  def set_card
    @card = current_user.cards
  end

  def set_card_first
    @card = current_user.cards.first
  end
end
