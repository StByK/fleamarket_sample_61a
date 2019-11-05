class CreateHouses < ActiveRecord::Migration[5.2]
  def change
    create_table :houses do |t|
      t.string :postal_code
      t.string :city

      t.string  :postal_code,     null: false
      t.integer :prefecture_id,   null: false
      t.string  :city,            null: false
      t.string  :street_name,     null: false
      t.string  :apt
      t.references  :user,        null: false, foreign_key: true

      t.timestamps
    end
  end
end
