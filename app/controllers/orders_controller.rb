class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  require "payjp"
  before_action :set_card

  def new
    @item = Item.find(params[:item_id])
    @image = @item.images[0]
    @order = Order.new
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

  def set_card
    @card = Card.where(user_id: current_user.id).first if Card.where(user_id: current_user.id).present?
  end
end
