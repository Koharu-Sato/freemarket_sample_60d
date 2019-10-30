class Item < ApplicationRecord
  belongs_to :saler, class_name: "User"
  belongs_to :buyer, class_name: "User", optional: true
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true
  has_many :category_items, dependent: :destroy
  has_many :categories, through: :category_items
  accepts_nested_attributes_for :category_items, allow_destroy: true
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  has_many :comments, dependent: :destroy
  has_many :messages, dependent: :destroy
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture

  def previous
    Item.order('created_at desc, id desc').where('created_at <= ? and id < ?', created_at, id).first
  end

  def next
    Item.order('created_at desc, id desc').where('created_at >= ? and id > ?', created_at, id).reverse.first
  end

  validates :name, presence: {message: '入力してください'}, length: {maximum: 40, message: "40 文字以下で入力してください"}
  validates :price, presence: {message:'300以上9999999以下で入力してください'}, numericality: {greater_than: 299, less_than: 10000000, message: '300以上9999999以下で入力してください'}
  validates :detail, presence: {message: '入力してください'}, length: {maximum: 1000, message: "1000 文字以下で入力してください"}
  validates :state, presence: {message: '入力してください'}
  validates :delivery_fee, presence: {message: '選択してください'}
  validates :delivery_method, presence: {message: '選択してください'}
  validates :delivery_date, presence: {message: '選択してください'}
end
