class ChangechangeImageOfImages < ActiveRecord::Migration[5.2]
  def change
    change_column_null :images, :image, false
  end
end
