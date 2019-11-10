class AddTelToHouses < ActiveRecord::Migration[5.2]
  def change
    add_column :houses, :phone_number, :text
  end
end
