class PurchaseController < ApplicationController
    # pay.jpの取り入れ
    require 'payjp'
  
    def index
      # 登録されたユーザーのカードを探す処理
      card = Card.where(user_id: current_user.id).first
     #登録された情報がない場合にカード登録画面に遷移
      if card.blank?
        redirect_to controller: "card", action: "new"
        # うまく行かない場合は、redirect_to card_path(current_user)
      else
        Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
        customer = Payjp::Customer.retrieve(card.customer_id)
        #保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
        @default_card_information = customer.cards.retrieve(card.card_id)
      end
    end
  
    def pay
  　　# 上記と同様
      card = Card.where(user_id: current_user.id).first
      Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
      Payjp::Charge.create(
      # itemテーブルに紐づけて価格を算出
      :amount => 　　　　　　 　　
      :customer => card.customer_id, 
      :currency => 'jpy', 
    )
    # 完了画面に遷移、マークアップしらんから適当
    redirect_to action: 'done' 
    end
  
    def done
    end
end
  

