class FavoritesController < ApplicationController
  before_action :set_variables

  def like
    favorite = current_user.favorites.new(item_id: @item.id)
    favorite.save
  end

  def unlike
    favorite = current_user.favorites.find_by(item_id: @item.id)
    favorite.destroy
  end

  private

  def set_variables
    @item = Item.find(params[:item_id])
    @id_name = "#like-link-#{@item.id}"
  end

end
