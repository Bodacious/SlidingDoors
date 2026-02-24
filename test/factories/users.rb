FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    shipping_address_line_1 { Faker::Address.street_name }
    shipping_address_line_2 { Faker::Address.secondary_address }
    shipping_address_postcode { Faker::Address.postcode }
    shipping_address_county { Faker::Address.state }
    shipping_address_country { Faker::Address.country }
    shipping_address_town { Faker::Address.city }
    billing_address_line_1 { Faker::Address.street_name }
    billing_address_line_2 { nil }
    billing_address_postcode { Faker::Address.postcode }
    billing_address_county { Faker::Address.state }
    billing_address_country { Faker::Address.country }
    billing_address_town { Faker::Address.city }
  end
end
