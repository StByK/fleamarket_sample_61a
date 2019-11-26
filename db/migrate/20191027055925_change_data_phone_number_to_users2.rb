class ChangeDataPhoneNumberToUsers2 < ActiveRecord::Migration[5.2]
  def change
    def change
      change_column :users, :phone_number, :string
    end  
  end
end
