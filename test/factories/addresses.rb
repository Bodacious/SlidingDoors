FactoryBot.define do
  factory :address do
    line_1 { Faker::Address.street_name }
    line_2 { Faker::Address.secondary_address }
    postcode { Faker::Address.postcode }
    town { Faker::Address.city }
    county { Faker::Address.state }
    country { "United Kingdom" }
    address_type { "shipping" }

    trait :shipping do
      address_type { "shipping" }
    end

    trait :billing do
      address_type { "billing" }
      line_2 { nil }
    end

    trait :registered do
      address_type { "registered" }
    end

    trait :australia do
      country { "Australia" }
    end

    trait :uk do
      country { "United Kingdom" }
    end
  end
end
