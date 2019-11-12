class Image < ApplicationRecord
  mount_uploader :image, ItemImageUploader
  belongs_to :item, inverse_of: :images,optional: true
end

