class AddressesController < ApplicationController
  before_action :authenticate_user!, only: [:edit]
  before_action :set_search, only: [:edit]

  def new
    @address = Address.new
  end

  def edit
    @user = User.find(params[:id])
    @address = @user.addresses[0]
    @user_birth = @user.birth_date
    @birth = @user_birth.strftime("%Y/%m/%d")
  end

  def create
    @address = Address.new(address_params)
    if @address.save
      redirect_to new_card_path
    else
      render :new
    end
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      redirect_to edit_address_path(@address.id), notice: '編集しました'
    else
      render :edit
    end
  end

  private

  def address_params
    params.require(:address).permit(:postal_code, :city, :block, :building, :tel, :prefecture_id).merge(user_id: current_user.id)
  end

  def set_search
    @search = Item.ransack(params[:q])
  end
  
end

