FactoryBot.define do
  factory :item do

    name              {Faker::Name.name}
    description       {Faker::Quote.yoda}
    condition         {Faker::Number.number(digits: 0)}
    shipment_fee      {Faker::Number.number(digits: 4)}
    shipment_method   {Faker::Number.number(digits: 0)}
    shipment_date     {Faker::Number.number(digits: 0)}
    prefecture_index  {Faker::Number.number(digits: 0)}
    price             {Faker::Number.number(digits: 0)}
    size              {Faker::Number.number(digits: 0)}
  end
end