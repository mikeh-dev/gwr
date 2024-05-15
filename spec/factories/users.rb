FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { "password123" }
    password_confirmation { "password123" }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    admin { false }
    
    factory :landlord do
      role { :landlord }
    end

    factory :tenant do
      role { :tenant }
    end
    
  end
end
