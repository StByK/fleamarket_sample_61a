class CreateDealings < ActiveRecord::Migration[5.2]
  def change
    create_table :dealings do |t|
      t.integer    :status,     null: false, default: 1
      t.references :item,       null: false, foreign_key: true
      t.references :seller,                  foreign_key: { to_table: :users }
      t.references :buyer,                   foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
