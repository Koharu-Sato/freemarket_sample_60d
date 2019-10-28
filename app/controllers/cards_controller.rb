class CardsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :show, :edit]
  require "payjp"
  before_action :set_card

  def new # カードの登録画面。送信ボタンを押すとcreateアクションへ。
    card = Card.where(user_id: current_user.id).first
    redirect_to action: "index" if card.present?
  end

  def show
    if @card.present?
      Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @card_information = customer.cards.retrieve(@card.card_id)
      @card_brand = @card_information.brand
      case @card_brand
      when "Visa"
        @card_src = "visa.png"
      when "JCB"
        @card_src = "jcbcard.png"
      when "MasterCard"
        @card_src = "mastercard.png"
      when "American Express"
        @card_src = "americanexpress.png"
      when "Diners Club"
        @card_src = "dinersclub.png"
      when "Discover"
        @card_src = "discover.png"
      end
    end
  end

  def edit
  end

  def destroy #PayjpとCardのデータベースを削除
    Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)
    customer = Payjp::Customer.retrieve(@card.customer_id)
    customer.delete
    if @card.destroy #削除に成功した時にポップアップを表示します。
      redirect_to card_path(current_user.id), notice: "削除しました"
    else #削除に失敗した時にアラートを表示します。
      redirect_to action: "edit", alert: "削除できませんでした"
    end
  end

  def create #PayjpとCardのデータベースを作成
    @url = request.referer
    Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)
    if params['payjp-token'].blank? && @url.match(/\/cards\/\d+\/edit/)
      redirect_to edit_card_path(current_user.id)
    elsif params['payjp-token'].blank?
      redirect_to action: "new"
    else
      # トークンが正常に発行されていたら、顧客情報をPAY.JPに登録します。
      customer = Payjp::Customer.create(card: params["payjp-token"])
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save && @url.match(/\/cards\/\d+\/edit/)
        redirect_to card_path(current_user.id)
      elsif @card.save
        redirect_to done_users_path
      elsif @url.match(/\/cards\/\d+\/edit/)
        redirect_to edit_card_path(current_user.id)
      else
        redirect_to action: "create"
      end
    end
  end

  def pay
    item = Item.find(params[:item])
    if item.buyer_id.nil? && item.saler_id != current_user.id
      item.update_attributes(buyer_id: current_user.id)
      order = Order.new(order_params)
      order.buyer_id = item.buyer_id
      order.save
      card = Card.where(user_id: current_user.id).first
        Payjp::Charge.create(
        amount: item.price, #支払金額を入力（itemテーブル等に紐づけても良い）
        customer: card.customer_id, #顧客ID
        currency: 'jpy', #日本円
      )
      redirect_to new_order_path(item.id), notice: "購入されました"
    else
      redirect_to new_order_path(item.id), notice: "既に購入されている方がいます"
    end
  end

  private

  def set_card
    @card = Card.where(user_id: current_user.id).first if Card.where(user_id: current_user.id).present?
  end

  def order_params
    params.require(:order).permit(:name, :detail, :state, :size, :delivery_fee, :delivery_method, :price, :delivery_date, :saler_id, :buyer_id, :item_id)
  end

end

# Payjp.api_key = 'sk_test_cfbdb30c289d9e6dfcd07fde'
