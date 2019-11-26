class AddSelleridToItem < ActiveRecord::Migration[5.2]
  def change
    add_reference :items, :seller, null: false, foreign_key: {to_table: :users}
  end
end
