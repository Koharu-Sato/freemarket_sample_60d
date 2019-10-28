class Image < ApplicationRecord
  belongs_to :item
  mount_uploader :image, ImageUploader
  validates :image, presence: {message: '画像がありません'}
end
