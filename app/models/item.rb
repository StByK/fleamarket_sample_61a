class Item < ApplicationRecord
  belongs_to :category
  belongs_to :brand,optional: true
  
  has_many   :images,dependent: :destroy
  accepts_nested_attributes_for :images

  has_one    :dealing,dependent: :destroy
  
  # belongs_to :user
  belongs_to :seller, class_name: "User", foreign_key: "seller_id"

  validates :name, presence: true, length: { maximum: 40 }
  validates :description, presence: true, length: { maximum: 1000 }
  validates :condition, presence: true
  validates :shipment_fee, presence: true
  validates :shipment_method, presence: true
  validates :shipment_date, presence: true
  validates :prefecture_index, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }
  validates :size, presence: true

  def previous
    Item.where("id < ?", self.id).order("id DESC").first
  end

  def next
    Item.where("id > ?", self.id).order("id ASC").first
  end

  enum size_enums: {"S": 1, "M": 2, "L": 3, "LL": 4, "23.0cm": 5,"23.5cm": 6, "24.0cm": 7, "24.5cm": 8, "25.0cm": 9, "25.5cm": 10, "26.0cm": 11, "26.5cm": 12, "27.0cm": 13,"その他": 99}
  


end