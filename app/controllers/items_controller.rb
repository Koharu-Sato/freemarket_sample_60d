class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :getCategory, :getAllCategory]
  before_action :set_category, only: [:new, :create, :edit]
  before_action :set_value, only: [:show, :pre_edit] 
  before_action :set_item, only: [:edit, :update, :destroy]

  def index
    #category
    #現在のカテゴリの総数を取得
    categoryItems = CategoryItem.all
    ids = []
    categoryItems.each do |categoryItem|
      id = categoryItem.category_id
      ids << id
    end
    #人気カテゴリ4つを取得
    category_ids = ids.map{ |id| Category.find(id).root.id }.group_by{|i| i}.map{|key,value| [key, value.count]}.sort_by{|a| a[1] }.reverse.map{|sss| sss[0] }.first(4)
    #全てのitem(40個)
    @all_items = []
    @categories = []
    category_ids.each do |category_id|
      #各カテゴリのitem(10個ずつ)
      items = []
      #各カテゴリに対し、最新の10件をcategory_itemモデルから取得
      category1 = Category.find(category_id)
      categoryItem = CategoryItem.where(category_id: category1.subtree).order(created_at: :desc).limit(10)
        categoryItem.each do |cItem|
          #取得したレコードからitem_idを取得
          itemId = cItem.item_id
          item = Item.find(itemId)
          items << item
        end
        @all_items << items
        category = Category.find(category_id)
        @categories << category
    end
    #brand
    @all_brand_items = []
    @brands = Item.where.not(brand: "").group(:brand).order(count_brand: :desc).limit(4).count(:brand).keys
    @brands.each do |brand|
      brand_items = []
      brandItems = Item.where(brand: brand).order(created_at: :desc).limit(10)
      brandItems.each do |item|
        brand_items << item
      end
      @all_brand_items << brand_items
    end
  end

  def getCategory
    @categoryList = Category.where(ancestry: nil) 
  end
  def getAllCategory
    # @categoryAll = Category.all
    @categoryAll = Category.find(params[:child_id]).children
  end

  def show
  end

  def new
    @item = Item.new
    @item.category_items.build
    @image = @item.images.build
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      # params[:images_attributes][:images.length][:image].each do |image|
      #   @item.images.create(image: image, item_id: @item.id)
      # end
      redirect_to root_path
    else
      render :new
    end
  end

  def get_children
    @children = Category.find(params[:parent_id]).children
  end

  def get_grandchildren
    @grandchildren = Category.find(params[:child_id]).children
  end

  def update
    if @item.saler_id == current_user.id && @item.update(item_params)
      redirect_to pre_edit_item_path(@item.id)
    else
      redirect_to root_path
    end
  end

  def edit
    num = @item.category_ids.first
    child = Category.find(num)
    @children = child.siblings
    @parent = child.parent
    @parents = @parent.siblings
    @grandparent = @parent.parent
    @grandparents = @grandparent.siblings
  end

  def pre_edit
    if @item.saler_id != current_user.id
      redirect_to root_path
    end
  end

  def destroy
    if @item.saler_id == current_user.id && @item.destroy
      redirect_to myitem_user_path(current_user.id)
    else
      redirect_to root_path
    end
  end

  def search
    before_uri = URI.parse(request.referer)
    @path = Rails.application.routes.recognize_path(before_uri.path)
    if @path[:action] == "index" || params[:q].present?
      @search = Item.ransack(search_params)
      @items = @search.result(distinct: true).references(:category_items, :categories).page(params[:page]).per(5)
    else
      params[:q] = { sorts:"id desc" }
      @search = Item.ransack()
      @items = Item.all
    end
  end

  private
  def item_params
    params.require(:item).permit(:name, :detail, :state, :size, :brand, :delivery_fee, :delivery_method, :price, :delivery_date, :prefecture_id, category_items_attributes: [:id, :category_id], images_attributes: [:id, :image]).merge(saler_id: current_user.id)
  end

  def set_category
    @category = Category.where(ancestry: nil)
  end

  def set_value
    @item = Item.find(params[:id])
    @image = Image.where(item_id: params[:id])
    @saler = User.find(@item.saler_id)
    @category = @item.categories[0]
    @address = Address.find_by(user_id: @saler.id)
    @salers_item = Item.where(saler_id: @saler.id)
    @order_count = @salers_item.where.not(buyer_id: nil).count
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def search_params
    params.require(:q).permit(:sorts, :name_cont, :brand_cont, :size_cont, :price_gteq, :price_lteq, :state_eq_any, :delivery_fee_eq_any, :buyer_id_not_null)
  end
end