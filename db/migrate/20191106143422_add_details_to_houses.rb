class AddDetailsToHouses < ActiveRecord::Migration[5.2]
  def change
    add_column :houses, :first_name, :string
    add_column :houses, :last_name, :string
    add_column :houses, :first_name_kana, :string
    add_column :houses, :last_name_kana, :string
  end
end
