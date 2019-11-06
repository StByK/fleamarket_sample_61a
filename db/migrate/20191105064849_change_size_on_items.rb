class ChangeSizeOnItems < ActiveRecord::Migration[5.2]
  def change
    change_column_null :items, :size, false
  end
end
