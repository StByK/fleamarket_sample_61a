class House < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to :user, optional: true

  validates :postal_code,       presence: true
  validates :prefecture_id,     presence: true
  validates :city,              presence: true
  validates :street_name,       presence: true
  validates :first_name,        presence: true
  validates :last_name,         presence: true
  validates :first_name_kana,   presence: true
  validates :last_name_kana,    presence: true

  #新規登録画面に使ってます
  enum days: {"1": 1, "2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7":7, "8": 8, "9": 9, "10": 10, "11": 11, "12": 12, "13": 13, "14": 14, "15": 15, "16": 16, "17": 17, "18": 18, "19":19, "20": 20, "21": 21, "22": 22,"23": 23, "24": 24, "25": 25, "26": 26, "27":27, "28": 28, "29": 29, "30": 30, "31": 31}

end
