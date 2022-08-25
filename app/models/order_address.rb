class OrderAddress
  include ActiveModel::Model
  attr_accessor :token, :postal_cord, :prefecture_id, :city, :address, :building, :phone_number, :user_id, :item_id
  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postal_cord, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :city
    validates :address
    validates :phone_number, format: {with: /\A[0-9]{10,11}\z/, message: 'is invalid. Input half-width characters' }
  end
  validates :prefecture_id, numericality: { other_than: 0, message: "can't be blank" }
  validates :building

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, address: address, building: building, phone_number: phone_number, order_id: order.id)
  end
end