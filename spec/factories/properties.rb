FactoryBot.define do
  factory :property do
    title { "Charming Cottage" }
    address { Faker::Address.street_address }
    postcode { Faker::Address.postcode }
    city { Faker::Address.city }
    property_type { ["house", "apartment", "commercial", "land"].sample }
  end
end