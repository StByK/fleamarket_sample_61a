class Item < ApplicationRecord
  belongs_to :category
  belongs_to :brand
  has_many   :images
  belongs_to :user

  validates :name, presence: true, length: { maximum: 40 }
  validates :description, presence: true, length: { maximum: 1000 }
  validates :condition, presence: true
  validates :shipment_fee, presence: true
  validates :shipment_method, presence: true
  validates :shipment_date, presence: true
  validates :prefecture_index, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }
  validates :size, presence: true
end