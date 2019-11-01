class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable,omniauth_providers: => [:facebook] # 一旦矢印
    has_one :sns_credential, dependent: :destroy

  validates :nickname, :first_name, :last_name, :first_name_kana, :last_name_kana, :phone_number, :birth_year, :birth_month, :birth_day, presence: true

def self.find_oauth(auth)
  
end


end

