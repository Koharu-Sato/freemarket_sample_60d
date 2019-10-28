class Order < ApplicationRecord
  belongs_to :saler, class_name: "User"
  validates :name, presence: true
  validates :price, presence: true
  validates :detail, presence: true
  validates :state, presence: true
  validates :delivery_fee, presence: true
  validates :delivery_method, presence: true
  validates :delivery_date, presence: true
  validates :buyer_id, presence: true
  validates :saler_id, presence: true
  validates :item_id, presence: true
end
