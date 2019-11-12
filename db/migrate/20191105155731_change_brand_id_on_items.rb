class ChangeBrandIdOnItems < ActiveRecord::Migration[5.2]
  def change
    change_column_null :items, :brand_id, true
  end
end
