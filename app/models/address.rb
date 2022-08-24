class Address < ApplicationRecord
  validates :postal_cord, presence: true, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Input half-width characters' }
  validates :prefecture_id, numericality: { other_than: 0, message: "can't be blank" }
  validates :city, presence: true
  validates :address, presence: true
  validates :building
  validates :phone_number, presence: true, format: { with: /\A[0-9]{10,11}\z/, message: 'is invalid. Input half-width characters' }

  belongs_to :prefecture
end