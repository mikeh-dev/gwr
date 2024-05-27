FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    sequence(:email) { |n| "user#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }

    factory :tenant do
      role { :tenant }
    end

    factory :landlord do
      role { :landlord }
    end

    factory :admin do
      role { :admin }
    end
  end
end