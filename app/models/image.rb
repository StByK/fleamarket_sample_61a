class Image < ApplicationRecord
  mount_uploaders :image, ItemImageUploader
  belongs_to :item, inverse_of: :images
end

