class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  validates :name, presence: true
  validates :price, numericality: { only_integer: true, message: 'is invalid. Input half-width characters' }
  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
  validates :info, presence: true
  validates :status_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :category_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :shipping_fee_status_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :prefecture_id, numericality: { other_than: 0, message: "can't be blank" }
  validates :scheduled_delivery_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :images, presence: true

  belongs_to :user
  belongs_to :status
  belongs_to :category
  belongs_to :shipping_fee_status
  belongs_to :prefecture
  belongs_to :scheduled_delivery
  has_many_attached :images
end
