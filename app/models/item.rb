class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user
  belongs_to :status
  belongs_to :category
  belongs_to :shipping_fee_status
  belongs_to :prefecture
  belongs_to :scheduled_delivery
  has_many_attached :images
  has_many :item_tag_relations
  has_many :tags, through: :item_tag_relations
end
