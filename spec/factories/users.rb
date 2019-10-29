FactoryBot.define do
  factory :user do

    password = Faker::Internet.password(min_length: 6)

    password {password}
    password_confirmation {password}
    nickname {Faker::Name.name}
    email {Faker::Internet.email}
    first_name {Faker::Name.first_name}
    last_name {Faker::Name.last_name}
    first_name_kana {Faker::Name.first_name}
    last_name_kana  {Faker::Name.last_name}
    phone_number {Faker::PhoneNumber.phone_number}
    profile_text {Faker::ChuckNorris.fact}
    icon_image {Faker::Internet.url}
    birth_year {Faker::Number.number(digits: 4)}
    birth_month {Faker::Number.number(digits: 2)}
    birth_day {Faker::Number.number(digits: 2)}
  end
end

