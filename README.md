# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

## usersテーブル
|column|Type|Option|
|-------|----|-----|
|nickname|string|null: false|
|email|string|null: false|
|password|string|null: false|
|first_name|string|null: false|
|first_name_kana|string|null: false|
|family_name|string|null: false|
|family_name_kana|string|null: false|
|birth_date|date|null: false|

### Association
- has_many :items, dependent: :destroy
- has_many :favorites
- has_many :orders
- has_many :reviews
- has_many :comments
- has_many :messages
- has_many :addresses, dependent: :destroy
- has_one  :card


## itemsテーブル
|column|Type|Option|
|-------|----|-----|
|name|string|null: false|
|detail|text||
|state|string|null: false|
|delivery_fee|string|null: false|
|price|integer|null: false|
|delivery_method|string|null: false|
|delivery_date|string|null: false|
|size|string||
|favorites_count|integer|
|buyer_id|integer|foreign_key: true|
|saler_id|integer|null: false, foreign_key: true|
|prefecture_id|integer|foreign_key: true|
|brand_id|references|foreign_key: true|

### Association
- belongs_to :user
- belongs_to :area
- belongs_to :brand
- has_many :images
- has_many :categories, through: :categories_items
- has_many :favorites, dependent: :destroy
- has_many :comments, dependent: :destroy
- has_many :messages, dependent: :destroy



## addressesテーブル
|column|Type|Option|
|-------|----|-----|
|postal_code|string||
|city|string|null: false|
|block|string|null: false|
|building|string||
|tel|string||
|user_id|references|null: false, foreign_key: true|
|prefecture_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :user


## categoriesテーブル
|column|Type|Option|
|-------|----|-----|
|category|string|null: false, unique: true|
|parent_id|integer||

### Association
- has_many :items,  through: :categories_items
- belongs_to :parent, class_name: :Category
- has_many :children, class_name: :Category, foreign_key: :parent_id


## categories_itemsテーブル
|column|Type|Option|
|-------|----|-----|
|category_id|integer|null: false, foreign_key: true|
|item_id|references|null: false, foreign_key: true|

### Association
- belongs_to :category
- belongs_to :item


## brandsテーブル
|column|Type|Option|
|-------|----|-----|
|brand|string||
|parent_id|integer||

### Association
- has_many :items
- belongs_to :parent, class_name: :Brand
- has_many :children, class_name: :Brand, foreign_key: :parent_id


## imagesテーブル
|column|Type|Option|
|-------|----|-----|
|image|string|null: false|
|item_id|references|null: false, foreign_key: true|

### Association
- belongs_to :item

## reviewsテーブル
|column|Type|Option|
|-------|----|-----|
|review|integer|null: false|
|text|text||
|user_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user

<!-- 自作 -->
## prefecturesテーブル
|column|Type|Option|
|-------|----|-----|
|name|string|null: false, unique: true|

### Association
- has_many :items

## commentsテーブル 
|column|Type|Option|
|-------|----|-----|
|comment|text|null: false|
|item_id|references|null: false, foreign_key: true|

### Association
- belongs_to :item

## favoritesテーブル
|column|Type|Option|
|-------|----|-----|
|item_id|references|null: false, foreign_key: true|
|user_id|references|null: false, foreign_key: true|

### Association
- belongs_to :item
- belongs_to :user

## messagesテーブル 
|column|Type|Option|
|-------|----|-----|
|message|text|null: false|
|item_id|references|null: false, foreign_key: true|
|user_id|references|null: false, foreign_key: true|

### Association
- belongs_to :item
- belongs_to :user

## ordersテーブル
|column|Type|Option|
|-------|----|-----|
|name|string|null: false|
|detail|text||
|state|string|null: false|
|delivery_fee|string|null: false|
|price|integer|null: false|
|delivery_method|string|null: false|
|delivery_date|string|null: false|
|buyer_id|integer|null: false, foreign_key: true|
|saler_id|integer|null: false, foreign_key: true|
|item_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user

## cardsテーブル
|column|Type|Option|
|-------|----|-----|
|card_id|string|null: false|
|customer_id|string|null: false|
|user_id|integer|null: false|

### Association
- belongs_to :user

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...