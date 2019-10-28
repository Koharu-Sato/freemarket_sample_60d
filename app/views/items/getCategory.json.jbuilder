json.array! @categoryList do |category|
  json.id category.id
  json.category category.category
  json.children category.children
end
