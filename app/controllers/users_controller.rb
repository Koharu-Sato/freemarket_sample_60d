class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:new]

  def show
  end
  
  def logout
  end

  def profile
  end

  def myitem
    @salers_item = Item.where(saler_id: params[:id])
  end

end
