crumb :root do
  link "メルカリ", root_path
end

crumb :user do
  link "マイページ", user_path
  parent :root
end

crumb :myitem do
  link "出品した商品 - 出品中", myitem_user_path
  parent :user
end

crumb :pre_edit do
  link "出品商品画面", pre_edit_item_path
  parent :myitem
end

crumb :profile do
  link "プロフィール", profile_user_path
  parent :user
end

crumb :card do
  link "支払い方法", card_path
  parent :user
end

crumb :edit do
  link "本人情報の登録", edit_user_path
  parent :user
end

crumb :logout do
  link "ログアウト", logout_user_path
  parent :user
end

crumb :item do
  @item = Item.find(params[:id])
  link "#{@item.name}", item_path
  parent :root
end

crumb :categories do
  link "カテゴリー一覧", categories_path
  parent :root
end

crumb :category do
  category = Category.find(params[:id])
  if category.parent.present?
    if category.parent.parent.present?
      link "#{category.parent.parent.category}", category_path(category.parent.parent.id)
      link "#{category.parent.category}", category_path(category.parent.id)
      link "#{category.category}", category_path
    else
      link "#{category.parent.category}", category_path(category.parent.id)
      link "#{category.category}", category_path
    end
  else
    link "#{category.category}", category_path
  end
  parent :categories
end




# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).