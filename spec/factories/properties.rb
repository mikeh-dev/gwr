FactoryBot.define do
  factory :property do
    title { "Charming Cottage" }
    address { Faker::Address.street_address }
    postcode { Faker::Address.postcode }
    city { Faker::Address.city }
    property_type { ["House", "Apartment", "Condo"].sample }
    association :owner, factory: :user
  end
end