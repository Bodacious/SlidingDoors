FactoryBot.define do
  factory :merchant do
    shipping_address_line_1 { Faker::Address.street_name }
    shipping_address_line_2 { Faker::Address.secondary_address }
    shipping_address_postcode { Faker::Address.postcode }
    shipping_address_town { Faker::Address.city }
    shipping_address_county { Faker::Address.state }
    shipping_address_country { "United Kingdom" }
    billing_address_line_1 { Faker::Address.street_name }
    billing_address_line_2 { nil }
    billing_address_postcode { Faker::Address.postcode }
    billing_address_town { Faker::Address.city }
    billing_address_county { Faker::Address.state }
    billing_address_country { "United Kingdom" }
    registered_address_line_1 { Faker::Address.street_name }
    registered_address_line_2 { Faker::Address.secondary_address }
    registered_address_postcode { Faker::Address.postcode }
    registered_address_town { Faker::Address.city }
    registered_address_county { Faker::Address.state }
    registered_address_country { "United Kingdom" }
  end
end
