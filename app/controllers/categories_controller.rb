class CategoriesController < ApplicationController
  
  def index
    @root_categories = Category.where(ancestry: nil)
  end

  def show
    @category = Category.find(params[:id])
    @categories = CategoryItem.where(category_id: @category.subtree_ids).map{|t| t.item_id}
    @items = Item.where(id: @categories).order(created_at: :desc)
    allids = @category.subtree_ids
    allitems = CategoryItem.where(category_id: allids)
    if allitems == []
      @length = 0
    else
      @length = allitems.length
    end
    @favorites_items = @items.order(favorites_count: :desc).limit(3)
  end
end
