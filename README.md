# mercari DB設計


## usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|integer|null: false|
|email|string|null: false, unique: true|
|password|string|null: false|
|birth_year|string|null: false|
|birth_month|string|null: false|
|birth_day|string|null: false|
|firstname|string|null: false|
|lastname|string|null: false|
|firstname_kana|string|null: false|
|lastname_kana|string|null: false|
|phone_number|integer|null: false|
|profile_text|string||
|icon_image|string||
|budget_id|integer|null: false, foreign_key, unique: true|
|settlements_id|integer|null: false, foreign_key, unique: true|

### Association
- has_one   :settlements      dependent: :destroy
- has_one   :budgets          dependent: :destroy
- has_one   :sns_credentials  dependent: :destroy
- has_many  :items            dependent: :destroy
- has_many  :dealings         dependent: :destroy
- has_many  :values           dependent: :destroy
- has_many  :todos            dependent: :destroy
- has_many  :informations
- has_many  :likes
- has_many  :addresses


## Informationsテーブル
|Column|Type|Options|
|------|----|-------|
|content|text|null: false|
|user_id|integer|foreign_key: true,  null: false|

### Association
- belongs_to :user


## Settlementsテーブル
|Column|Type|Options|
|------|----|-------|
|card_number|integer|null: false, unique: true|
|card_date|integer|null: false, unique: true|
|sec_code|integer|null: false, unique: true|
|user_id|integer|foreign_key: true,  null: false|

### Association
- belongs_to :user


## Valuesテーブル
|Column|Type|Options|
|------|----|-------|
|good|string|null: false|
|soso|string|null: false|
|bad|string|null: false|
|comment|string||
|buyer_id|integer|foreign_key: { to_table: :users },  null: false|
|seller_id|integer|foreign_key: { to_table: :users }  null: false|

### Association
- belongs_to :buyer,   class_name: 'User', foreign_key: 'buyer_id'
- belongs_to :seller,  class_name: 'User', foreign_key: 'seller_id'


## Addressesテーブル
|Column|Type|Options|
|------|----|-------|
|zip_code|integer|null: false|
|prefecture|string|null: false|
|city|string|null: false|
|street|string|null: false|
|apt|string||
|user_id|integer|foreign_key: true,  null: false|

### Association
- belongs_to :user


## Sns_credentialsテーブル
|Column|Type|Options|
|------|----|-------|
|provider|string|null: false|
|unique_identifier|string|null: false|
|user_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :user


## Todoesテーブル
|Column|Type|Options|
|------|----|-------|
|content|text|null: false|
|user_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :dealings


## Budgetsテーブル
|Column|Type|Options|
|------|----|-------|
|cash_balance|integer|null: false|
|point_balance|integer|null: false|
|user_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :user


## Dealingsテーブル
|Column|Type|Options|
|------|----|-------|
|item_id|integer|null: false, foreign_key: true|
|buyer_id|integer|foreign_key: { to_table: :users },  null: false|
|seller_id|integer|foreign_key: { to_table: :users }  null: false|

### Association
- belongs_to :item
- belongs_to :buyer,   class_name: 'User', foreign_key: 'buyer_id'
- belongs_to :seller,  class_name: 'User', foreign_key: 'seller_id'


## Itemsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|description|string|null: false|
|condition|string|null: false|
|shipment_fee|string|null: false|
|shipment_method|string|null: false|
|shipment_date|string|null: false|
|prefecture_index|integer|null: false|
|price|integer|null: false|
|size|string|null: false|
|seller_id|integer|foreign_key: { to_table: :users }  null: false|
|category_id|integer|null: false, foreign_key: true|
|brand_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :seller, class_name: 'User', foreign_key: 'seller_id'
- belongs_to :brand
- belongs_to :categories
- has_one    :dealing
- has_many   :images,   dependent: :destroy
- has_many   :likes,    dependent: :destroy
- has_many   :comments, dependent: :destroy


## Commentsテーブル
|Column|Type|Options|
|------|----|-------|
|context|text|null: false|
|item_id|integer|null: false, foreign_key: true|
|user_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :item
- belongs_to :user


## Imagesテーブル
|Column|Type|Options|
|------|----|-------|
|image|string|null: false|
|item_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :item


## Brandsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false, unique: true|

### Association
- has_many :items
- has_many :brand_category_tags
- has_many :brand_categories, through :brand_category_tags


## Brand_category_tagsテーブル
|Column|Type|Options|
|------|----|-------|
|brand_id|integer|null: false, unique: true|
|brand_category_id|integer|null: false, unique: true|

### Association
- belongs_to :brand_category
- belongs_to :brand


## Brand_categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|category_name|string|null: false, unique: true|

### Association
- has_many :brand_category_tags
- has_many :brands, through: brand_category_tags


## Categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false, unique: true|
|ancestry|string||

### Association
- has_many :items
- has_many :brand_tags
- has_many :brands, through :brand_tags


## Likesテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|foreign_key: true,  null: false|
|item_id|integer|foreign_key: true,  null: false|

### Association
- belongs_to :user
- belongs_to :item
