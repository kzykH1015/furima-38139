class Address < ApplicationRecord
  validates :postal_cord, presence: true
  validates :prefecture_id, numericality: { other_than: 0, message: "can't be blank" }
  validates :city, presence: true
  validates :address, presence: true
  validates :building
  validates :phone_number, presence: true

  belongs_to :prefecture
end