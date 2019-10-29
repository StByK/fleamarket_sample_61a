FactoryBot.define do
  factory :user do
    password = Faker::Internet.password(min_length: 6)
    password {password}
    password_confirmationn {password}
    nickname {Faker::Name.name}
    email {Faker::Internet.free_email}
    first_name {Faker::name.first_name}
    last_name {Faker::name.last_name}
    first_name_kana {Faker::name.first_name}
    last_name_kana  {Faker::name.last_name}
    phone_number {Faker::PhoneNumber.phone_number}
    profile_text {Faker::ChuckNorris.fact}
    icon_image {Faker::Internet.url}
    birth_year {Faker::Number.number}
    birth_month {Faker::Number.number}
    birth_day {Faker::Number.number}
  end
end

