class Tag < ApplicationRecord
  has_many :item_tag_relation
  has_many :items, thorugh: :item_tag_relation

  validates :tag_name, uniqueness: true
end
