class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string,  :name,                      null: false
      t.string,  :description,               null: false
      t.string,  :condition,                 null: false
      t.string,  :shipment_fee,              null: false
      t.string,  :shipment_method,           null: false
      t.string,  :shipment_date,             null: false
      t.integer, :prefecture_index,          null: false
      t.integer, :price,                     null: false
      t.string,  :size,

      t.timestamps
    end
  end
end
