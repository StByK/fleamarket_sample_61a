class Image < ApplicationRecord
  mount_uploader :image, Item_image_Uploader
  belongs_to :item
end
