class Item < ApplicationRecord
  validates :name, presence: true
  validates :price, presence: true
  validates :info, presence: true
  validates :status_id, numericality: { other_than: 1, message: "can't be blank"} 
  validates :category_id, numericality: { other_than: 1, message: "can't be blank" } 
  validates :shipping_fee_status_id, numericality: { other_than: 1, message: "can't be blank" } 
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" } 
  validates :scheduled_delivery_id, numericality: { other_than: 1, message: "can't be blank" } 
  validates :user, presence: true 
end