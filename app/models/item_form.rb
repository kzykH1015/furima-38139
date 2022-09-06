class ItemForm
  include ActiveModel::Model

  attr_accessor(
    :name, :price, :info, :status_id, :category_id, :shipping_fee_status_id,
    :prefecture_id, :scheduled_delivery_id, :images, :user_id, :id, :created_at,
    :datetime, :updated_at, :datetime, :tag_name
  )

  with_options presence: true do
    validates :name
    validates :price, numericality: { only_integer: true, message: 'は半角数字で入力してください' }
    validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
    validates :info
    validates :status_id, numericality: { other_than: 1, message: 'を選択してください' }
    validates :category_id, numericality: { other_than: 1, message: 'を選択してください' }
    validates :shipping_fee_status_id, numericality: { other_than: 1, message: 'を選択してください' }
    validates :prefecture_id, numericality: { other_than: 0, message: 'を選択してください' }
    validates :scheduled_delivery_id, numericality: { other_than: 1, message: 'を選択してください' }
    validates :images, length: { minimum: 1, maximum: 5, message: 'は1枚以上5枚以下にしてください' }
  end

  def save
    item = Item.create(
      name: name, price: price, info: info, status_id: status_id, category_id: category_id,
      shipping_fee_status_id: shipping_fee_status_id, prefecture_id: prefecture_id,
      scheduled_delivery_id: scheduled_delivery_id, images: images, user_id: user_id
    )
    tag = Tag.where(tag_name: tag_name).first_or_initialize
    tag.save
    ItemTagRelation.create(item_id: item.id, tag_id: tag.id)
  end

  def update(params, item)
    item.item_tag_relations.destroy_all

    tag_name = params.delete(:tag_name)

    tag = Tag.where(tag_name: tag_name).first_or_initialize if tag_name.present?

    tag.save if tag_name.present?
    item.update(params)
    ItemTagRelation.create(item_id: item.id, tag_id: tag.id) if tag_name.present?
  end
end
